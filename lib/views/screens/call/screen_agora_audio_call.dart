import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_call.dart';

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
  @override
  void initState() {
    final CallController callController = Get.put(CallController(token: widget.token, channelId: widget.channelId, isVideoCall: false));

    super.initState();
    callController.initAgora(); // Initialize Agora in the controller
  }

  @override
  Widget build(BuildContext context) {
    CallController callController = Get.find<CallController>();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.callerImageUrl),
                  radius: 40,
                ),
                SizedBox(height: 10),
                Text(
                  widget.callerName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Obx(() => Text(
                  callController.statusMessage.value,
                  style: TextStyle(color: Colors.grey),
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => CircleButton(
                  icon: callController.isMuted.value ? Icons.mic_off : Icons.mic,
                  iconColor: callController.isMuted.value ? Colors.red : Colors.white,
                  onPressed: callController.toggleMute,
                )),
                CircleButton(
                  icon: Icons.call_end,
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                  onPressed: callController.endCall,
                ),
              ],
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
