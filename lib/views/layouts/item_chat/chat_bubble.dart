import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../screens/screen_chat_video_player.dart';

class ChatBubble extends StatefulWidget {
  final String content;
  final bool isCurrentUser;
  final bool? isGroupChat;
  final bool? userDetail;
  final String? secondPersonName;
  final bool isAudio;
  final bool isVideo;
  final String? audioUrl; // Add URL for audio
  final String? videoUrl; // Add URL for video

  const ChatBubble({
    Key? key,
    required this.content,
    required this.isCurrentUser,
    this.isGroupChat = false,
    this.userDetail,
    this.secondPersonName,
    this.isAudio = false,
    this.isVideo = false,
    this.audioUrl,
    this.videoUrl,
  }) : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late AudioPlayer _audioPlayer;
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (widget.isAudio && widget.audioUrl != null) {
      _audioPlayer = AudioPlayer();
    }
    if (widget.isVideo && widget.videoUrl != null) {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {}); // Update UI when video is loaded
        });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isGroupChat!)
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: widget.isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.isVideo && widget.videoUrl != null) {
                      Get.to(() => VideoPlayerScreen(videoUrl: widget.videoUrl!));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xff333333),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.isCurrentUser ? 15.0 : 2.0),
                        topRight: Radius.circular(widget.isCurrentUser ? 2.0 : 15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: widget.isVideo
                          ? _buildVideoPreview()
                          : Text(
                        widget.content,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                if (widget.userDetail == false)
                  Text(
                    "You",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (widget.userDetail == true && widget.secondPersonName != null)
                  Text(
                    widget.secondPersonName!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          if (widget.isGroupChat!)
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoPreview() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 178.w,
        maxHeight: 150.h,
      ),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Icon(
          Icons.play_circle_fill,
          color: Colors.white.withOpacity(0.7),
          size: 64.sp,
        ),
      ),
    );
  }
}
