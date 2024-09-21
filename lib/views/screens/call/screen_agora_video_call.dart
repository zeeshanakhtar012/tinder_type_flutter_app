import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/views/screens/call/agora_constants.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraVideoCall extends StatefulWidget {
  final String channelId;
  final String callerName;
  final String callerImageUrl;
  final String token;

  AgoraVideoCall({
    Key? key,
    required this.channelId,
    required this.callerName,
    required this.callerImageUrl,
    required this.token,
  }) : super(key: key);

  @override
  _AgoraVideoCallState createState() => _AgoraVideoCallState();
}

class _AgoraVideoCallState extends State<AgoraVideoCall> {
  late RtcEngine _engine;
  bool _localUserJoined = false;
  bool _isMuted = false;
  bool _isCameraEnabled = true;
  bool _isSwapped = false; // Added for swapping local and remote video
  int? _remoteUid;
  String _statusMessage = 'Joining the call...';

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    try {
      // Request necessary permissions
      var cameraStatus = await Permission.camera.status;
      var microphoneStatus = await Permission.microphone.status;

      if (!cameraStatus.isGranted || !microphoneStatus.isGranted) {
        await [Permission.microphone, Permission.camera].request();
      }

      // Initialize Agora engine
      _engine = createAgoraRtcEngine();
      await _engine.initialize(RtcEngineContext(appId: AgoraConstants.appId));

      // Register event handlers before enabling video
      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            setState(() {
              _localUserJoined = true;
              _statusMessage = 'Waiting for the other user to join...';
            });
            print('Successfully joined the channel: ${widget.channelId}');
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            setState(() {
              _remoteUid = remoteUid;
              _statusMessage = 'Connected';
            });
            print('Remote user joined: $remoteUid');
          },
          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            setState(() {
              _remoteUid = null;
              _statusMessage = 'User disconnected';
              Navigator.pop(context);
            });
            print('Remote user left: $remoteUid');
          },
        ),
      );

      // Enable video after initializing
      await _engine.enableVideo();
      await _engine.switchCamera(); // Set front camera by default

      // Join the channel
      await _engine.joinChannel(
        token: widget.token,
        channelId: widget.channelId,
        options: const ChannelMediaOptions(
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
        uid: 0, // Ensure uid is correctly set
      );
    } catch (e) {
      setState(() {
        _statusMessage = 'Error initializing Agora: $e';
      });
      print('Agora initialization error: $e');
    }
  }

  Future<void> _toggleMute() async {
    setState(() {
      _isMuted = !_isMuted;
    });
    await _engine.muteLocalAudioStream(_isMuted);
  }

  Future<void> _toggleCamera() async {
    setState(() {
      _isCameraEnabled = !_isCameraEnabled;
    });
    await _engine.muteLocalVideoStream(!_isCameraEnabled);
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
  }

  Future<void> _endCall() async {
    await _engine.leaveChannel();
    await _engine.release();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _endCall();
    super.dispose();
  }

  Widget _renderLocalPreview() {
    if (_localUserJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _engine,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Center(child: Text('Joining the call...', style: TextStyle(color: Colors.white)));
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelId), // Pass the correct channelId
        ),
      );
    } else {
      return const Center(
        child: Text('Waiting for remote user...', style: TextStyle(color: Colors.white)),
      );
    }
  }

  Widget _renderVideo() {
    if (_isSwapped) {
      return Stack(
        children: [
          _remoteUid != null ? _renderLocalPreview() : _renderRemoteVideo(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                height: 200.h,
                width: 130.w,
                child: _remoteUid != null ? _renderRemoteVideo() : _renderLocalPreview(),
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          _remoteUid != null ? _renderRemoteVideo() : _renderLocalPreview(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                height: 250.h,
                width: 150.w,
                child: _renderLocalPreview(),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSwapped = !_isSwapped; // Swap the video feeds
                });
              },
              child: _renderVideo(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        iconColor: _isMuted ? Colors.red : Colors.white,
                        onPressed: _toggleMute,
                      ),
                      CircleButton(
                        icon: Icons.call_end,
                        backgroundColor: Colors.red,
                        iconColor: Colors.white,
                        onPressed: _endCall,
                      ),
                      CircleButton(
                        icon: _isCameraEnabled ? Icons.videocam : Icons.videocam_off,
                        iconColor: _isCameraEnabled ? Colors.green : Colors.white,
                        onPressed: _toggleCamera,
                      ),
                      CircleButton(
                        icon: Icons.switch_camera,
                        iconColor: Colors.white,
                        onPressed: _switchCamera,
                      ),
                    ],
                  ),
                ],
              ),
            ).marginOnly(
              bottom: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CircleButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.backgroundColor = Colors.black54,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: backgroundColor,
      padding: const EdgeInsets.all(20.0),
      child: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
    );
  }
}
