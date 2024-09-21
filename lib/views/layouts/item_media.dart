import 'dart:developer';
import 'dart:io';

// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:blaxity/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/firebase_utils.dart';
import '../../../models/message.dart';
import 'item_message_audio.dart';

class ItemMedia extends StatelessWidget {
  Message message;
  String chatId;
  bool showImage;
  bool? personalChat;
  String notificationToken;
  List<String> notificationsList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset messageOffset = renderBox.localToGlobal(Offset.zero);
          Size messageSize = renderBox.size;
        },
        onTap: () {
          downloadMedia(context, message.fileMessage!.fileUrl,
              message.fileMessage!.fileName);
        },
        child: Align(
          alignment: message.senderId == FirebaseUtils.myId
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
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
                                width: 32.w,
                                height: 32.h,
                              ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            message.senderId == FirebaseUtils.myId
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          if (personalChat == false && showImage)
                            Text(
                              message.senderName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontFamily: "Inter"),
                            ).marginOnly(top: 4.0),
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 4.0),
                                decoration: BoxDecoration(
                                  color: AppColors.chatColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        message.senderId == FirebaseUtils.myId
                                            ? 15.0
                                            : 2.0),
                                    bottomRight: Radius.circular(
                                        message.senderId == FirebaseUtils.myId
                                            ? 2.0
                                            : 15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 2),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 6.h),
                                      width: Get.width * 0.5,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_copy_rounded,
                                            color: Colors.white,
                                            size: 30.h,
                                          ).marginOnly(right: 10.w),
                                          Expanded(
                                            child: Text(
                                              message.fileMessage!.fileName,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          if (message.senderId == FirebaseUtils.myId)
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
            ],
          ),
        ));
  }


  void downloadMedia(context, String url, String name) async {
    // Use the download link to download the file
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.refFromURL(url);

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final File localFile =
        File('${appDocDir.path}/$name'); // Change the file name as needed

    try {
      await ref.writeToFile(localFile);
      print('File downloaded and saved to: ${localFile.path}');
      // await OpenAppFile.open(
      //   localFile.path,
      // ).catchError((error) {
      //   log(error.toString());
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text("No App to open this file")));
      // });
    } catch (e) {
      log(e.toString());
    }
  }

  ItemMedia({
    required this.message,
    required this.chatId,
    required this.showImage,
    this.personalChat = false,
    required this.notificationToken,
    required this.notificationsList,
  });
}
