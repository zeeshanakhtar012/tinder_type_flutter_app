import 'package:blaxity/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/firebase_utils.dart';
import '../../models/message.dart';
import '../screens/screen_full_videoPlayer.dart';
import 'item_message_audio.dart';

class VideoMessageBubble extends StatefulWidget {
  final Message message;
  String chatId;
  bool showImage;
  bool? personalChat;
  String notificationToken;
  List<String> notificationsList;

  @override
  _VideoMessageBubbleState createState() => _VideoMessageBubbleState();

  VideoMessageBubble({
    required this.message,
    required this.chatId,
    required this.showImage,
    this.personalChat = false,
    required this.notificationToken,
    required this.notificationsList,
  });
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.message.videoMessage!.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(
          () {}); // Ensure the first frame is shown after the video is initialized
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(
            videoUrl: widget.message.videoMessage!.videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = widget.message.senderId == FirebaseUtils.myId;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: GestureDetector(

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.personalChat == true
                ? SizedBox()
                : (widget.message.senderId != FirebaseUtils.myId &&
                        widget.showImage)
                    ? Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${widget.message.senderProfileImage}"))),
                      )
                    : SizedBox(
                        width: 35.w,
                        height: 35.h,
                      ),
            Expanded(
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (widget.showImage && widget.personalChat == false)
                    Text(
                      widget.message.senderName,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ).marginOnly(top: 4.0),
                  GestureDetector(
                    onTap: () => _navigateToFullScreen(context),
                    child: Container(
                      height: 150.h,
                      width: 178.w,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 4.0),
                      decoration: BoxDecoration(
                        color: AppColors.chatColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isCurrentUser ? 15.0 : 2.0),
                          bottomRight: Radius.circular(isCurrentUser ? 2.0 : 15.0),
                          bottomLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  if (isCurrentUser)
                    Text(
                      widget.message.status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                ],
              ),
            ),
            widget.personalChat == true
                ? SizedBox()
                : (widget.message.senderId == FirebaseUtils.myId &&
                        widget.showImage)
                    ? Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${widget.message.senderProfileImage}"))),
                      )
                    : SizedBox(
                        width: 35.w,
                        height: 35.h,
                      ),
          ],
        ),
      ),
    );
  }

}
