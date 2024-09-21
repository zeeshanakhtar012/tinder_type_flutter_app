import 'dart:math' as m;

import 'package:blaxity/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/message.dart';
import '../../constants/firebase_utils.dart';
import '../screens/screen_full_image_preview.dart';
import 'item_message_audio.dart';

class ImageMessageBubble extends StatelessWidget {
  final Message message;
  bool showImage;
  bool? personalChat;
  String notificationToken;
  List<String> notificationsList;

  String chatId;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.senderId == FirebaseUtils.myId;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: GestureDetector(

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            personalChat == true
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
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ).marginOnly(top: 4.0),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        padding: EdgeInsets.all(8),
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
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(24.r),
                          child: InkWell(
                            onTap: () {
                              Get.to(ScreenFullImagePreview(
                                imageUrl: message.imageMessage!.imageUrl,
                              ));
                            },
                            child: Image.network(
                              message.imageMessage!.imageUrl,
                              width: 178.w,
                              fit: BoxFit.cover,
                              height: 150.h,
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
            personalChat == true
                ? SizedBox()
                : (message.senderId == FirebaseUtils.myId && showImage)
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
          ],
        ),
      ),
    );
  }



  Future<String> linkSize(String url) async {
    String? fileSize = "";
    try {
      http.Response response = await http.head(Uri.parse(url));
      fileSize = response.headers["content-length"];
      int bytes = int.parse(fileSize!);
      if (bytes <= 0) {
        fileSize = "0 B";
      }
      const suffixes = ["B", "KB", "MG", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (m.log(bytes) / m.log(1024)).floor();
      fileSize =
          '${(bytes / m.pow(1024, i)).toStringAsFixed(0)} ${suffixes[i]}';
    } catch (err) {
      fileSize = "0 B";
    }
    return fileSize!;
  }

  ImageMessageBubble({
    required this.message,
    required this.showImage,
    this.personalChat = false,
    required this.notificationToken,
    required this.notificationsList,
    required this.chatId,
  });
}
