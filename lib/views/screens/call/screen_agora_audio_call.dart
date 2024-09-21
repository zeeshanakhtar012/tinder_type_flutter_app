import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraAudioCall extends StatefulWidget {
  final String channelId;
  final String callerName;
  final String callerImageUrl;
  final String token;

  AgoraAudioCall({
    Key? key,
    required this.channelId,
    required this.callerName,
    required this.callerImageUrl,
    required this.token,
  }) : super(key: key);

  @override
  _AgoraAudioCallState createState() => _AgoraAudioCallState();
}

class _AgoraAudioCallState extends State<AgoraAudioCall> {
  late RtcEngine _engine;
  bool _localUserJoined = false;
  bool _isMuted = false;
  bool _isSpeakerEnabled = false;
  int? _remoteUid;
  String _statusMessage = 'Joining the call...';

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    try {
      // Request permissions
      await [Permission.microphone, Permission.audio].request();

      // Initialize Agora engine
      _engine = createAgoraRtcEngine();
      await _engine.initialize(RtcEngineContext(appId: '4933a44ec0ef4d35957206e0c86e0035'));

      // Register event handlers
      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            setState(() {
              _localUserJoined = true;
              _statusMessage = 'Waiting for the other user to join...';
            });
            print('Successfully joined the channel with ID: ${widget.channelId}');
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            setState(() {
              _remoteUid = remoteUid;
              _statusMessage = 'Connected';
            });
            print("Remote user joined channel: $remoteUid");
          },
          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            setState(() {
              _remoteUid = null;
              _statusMessage = 'User disconnected';
              Navigator.pop(context);
            });
            print("Remote user $remoteUid left the channel");
          },
          onAudioVolumeIndication: (RtcConnection connection, List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
            for (var speaker in speakers) {
              if (speaker.uid == 0) {
                print("Local user volume: ${speaker.volume}");
              } else {
                print("Remote user ${speaker.uid} volume: ${speaker.volume}");
              }
            }
          },
          onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid, RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
            if (state == RemoteAudioState.remoteAudioStateStopped) {
              setState(() {
                _statusMessage = 'You were muted by the remote user';
              });
              print("Remote user $remoteUid muted their audio");
            } else if (state == RemoteAudioState.remoteAudioStateDecoding) {
              setState(() {
                _statusMessage = 'Remote user unmuted';
              });
              print("Remote user $remoteUid unmuted their audio");
            }
          },
        ),
      );

      // Join channel
      await _engine.joinChannel(
        token: widget.token,
        channelId: widget.channelId,
        options: const ChannelMediaOptions(
          autoSubscribeAudio: true,
          publishMicrophoneTrack: true,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
        uid: 0,
      );

      // Enable speakerphone (comment this out if causing issues)
      // await _engine.setEnableSpeakerphone(true);

    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to join channel: $e';
      });
      print('Error during Agora initialization: $e');
    }
  }

  Future<void> _toggleMute() async {
    setState(() {
      _isMuted = !_isMuted;
    });
    await _engine.muteLocalAudioStream(_isMuted);
  }

  Future<void> _toggleSpeaker() async {
    setState(() {
      _isSpeakerEnabled = !_isSpeakerEnabled;
    });
    try {
      await _engine.setEnableSpeakerphone(_isSpeakerEnabled);
    } catch (e) {
      print('Error setting speakerphone: $e');
    }
  }

  Future<void> _endCall() async {
    await _engine.leaveChannel();
    await _engine.release();
  if(mounted){
    Navigator.pop(context);
  }
  }

  @override
  void dispose() {
    _endCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    print(widget.channelId);
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.callerImageUrl),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.callerName,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _statusMessage,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
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
                    icon: _isSpeakerEnabled ? Icons.volume_up : Icons.volume_off,
                    iconColor: _isSpeakerEnabled ? Colors.green : Colors.white,
                    onPressed: _toggleSpeaker,
                  ),
                ],
              ),
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
