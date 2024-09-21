import 'package:blaxity/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/firebase_utils.dart';
import '../../models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  String chatId;
  bool showImage;
  bool? personalChat;
  String notificationToken;
  List<String> notificationsList;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.senderId == FirebaseUtils.myId;
    String url = extractUrl(message.content);

    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (personalChat == true)
              ? SizedBox()
              : (message.senderId != FirebaseUtils.myId && showImage)
                  ? Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${message.senderProfileImage}"))),
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
                if (personalChat == false && showImage)
                  Text(
                    message.senderName,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ).marginOnly(
                    top: 4.0,
                  ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        launch(url);
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.chatColor,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(isCurrentUser ? 15.0 : 2.0),
                            bottomRight:
                                Radius.circular(isCurrentUser ? 2.0 : 15.0),
                            bottomLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: message.content.replaceAll(url, ''),
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: url,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ).marginOnly(right: 20.w),

                              // Show "Seen" text for sent messages
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                if (isCurrentUser)
                  Text(
                    message.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
              ],
            ),
          ),
          (personalChat == true)
              ? SizedBox()
              : (message.senderId == FirebaseUtils.myId && showImage)
                  ? Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.chatColor,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${message.senderProfileImage}"))),
                    )
                  : SizedBox(
                      width: 35.w,
                      height: 35.h,
                    ),
        ],
      ),
    );
  }


  String extractUrl(String content) {
    final urlPattern = RegExp(
      r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+', // Simple URL regex
      caseSensitive: false,
    );
    final match = urlPattern.firstMatch(content);
    return match?.group(0) ?? '';
  }

  Future<void> _launchUrl(String content) async {
    final urlPattern = RegExp(
      r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+', // Simple URL regex
      caseSensitive: false,
    );
    final match = urlPattern.firstMatch(content);
    String url = match?.group(0) ?? '';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ChatBubble({

    required this.message,
    required this.chatId,
    required this.showImage,
    this.personalChat = false,
    required this.notificationToken,
    required this.notificationsList,
  });
}
