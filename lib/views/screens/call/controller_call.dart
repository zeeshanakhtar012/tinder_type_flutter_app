import 'package:agora_uikit/agora_uikit.dart';
import 'package:blaxity/views/screens/call/agora_constants.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  // Agora engine instance
  RtcEngine? _engine;
  bool isVideoCall;
  String token;
  String channelId;

  CallController(
      {required this.token,
      required this.channelId,
      required this.isVideoCall});

  // Call state variables
  RxBool isJoined = false.obs;
  RxBool isMuted = false.obs;
  RxBool isCameraEnabled = true.obs; // For video calls
  RxBool isRemoteUserConnected = false.obs;
  RxString statusMessage = 'Joining the call...'.obs;

  // Function to initialize Agora
  Future<void> switchCamera() async {
      await _engine?.switchCamera();
    }


  Future<void> initAgora() async {
    try {
      // Request necessary permissions
      await [Permission.microphone, Permission.camera].request();

      // Initialize Agora engine
      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(appId: AgoraConstants.appId));

      // Register event handlers
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            isJoined.value = true;
            statusMessage.value = 'Waiting for the other user to join...';
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            isRemoteUserConnected.value = true;
            statusMessage.value = 'Connected';
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            isRemoteUserConnected.value = false;
            statusMessage.value = 'User disconnected';
            endCall();
          },
          // ... other event handlers for audio volume, mute state, etc.
        ),
      );

      if (isVideoCall) {
        await _engine!.enableVideo();
        await _engine!.switchCamera(); // Set front camera by default
      }
      // Join channel
      await _engine!.joinChannel(
        token: token,
        channelId: channelId,
        options: const ChannelMediaOptions(
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
          // For video calls
          publishMicrophoneTrack: true,
          isAudioFilterable: true,
          publishCameraTrack: true,
          // For video calls
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
        uid: 0,
      );
    } catch (e) {
      statusMessage.value = 'Failed to join channel: $e';
      print('Error during Agora initialization: $e');
    }
  }

  // Function to toggle mute
  Future<void> toggleMute() async {
    isMuted.value = !isMuted.value;
    await _engine!.muteLocalAudioStream(isMuted.value);
  }

  // Function to toggle camera (for video calls)
  Future<void> toggleCamera() async {
    isCameraEnabled.value = !isCameraEnabled.value;
    await _engine!.muteLocalVideoStream(!isCameraEnabled.value);
  }

  // Function to end call
  Future<void> endCall() async {
    if (isJoined.value) {
      try {
        await _engine!.muteLocalAudioStream(true);
        await _engine!.muteLocalVideoStream(true);

        // Leave the Agora channel
        await _engine!.leaveChannel();

        // Release the Agora engine to free resources
        await _engine!.release();

        // Update the state
        isJoined.value = false;
        isRemoteUserConnected.value = false;

        // Check if the call was declined and navigate back
        if (Get.context != null) {
          Navigator.pop(Get.context!); // This will pop the current call screen
          // Alternatively, you can use Get.back() if you are using GetX for navigation.
          // Get.back();
        }
      } catch (e) {
        print("Error ending call: $e");
      }
    }
  }
}
