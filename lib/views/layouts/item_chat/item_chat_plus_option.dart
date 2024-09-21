import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemPlusChatOptions{
  static void showChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              height: 240.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined, color:Colors.white,)),
                          Text("Camera"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.image_outlined, color:Colors.white,)),
                          Text("Gallery")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.picture_as_pdf, color:Colors.white,)),
                          Text("Pdf"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.file_copy, color:Colors.white,)),
                          Text("File")
                        ],
                      ),
                    ],
                  ).marginOnly(top: 6.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.share_location_sharp, color:Colors.white,)),
                          Text("Location")
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.audio_file_outlined, color:Colors.white,)),
                          Text("Audio"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.import_contacts, color:Colors.white,)),
                          Text("Contacts"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined, color:Colors.white,)),
                          Text("Link"),
                        ],
                      ),
                    ],
                  ).marginOnly(top: 6.sp),
                ],
              ),
            );
          },
        );
      },
    );
  }
}