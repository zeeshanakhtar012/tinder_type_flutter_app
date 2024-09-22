import 'package:blaxity/views/screens/screen_full_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';

class ScreenViewUserPhotos extends StatelessWidget {
 List<String> imagesList;
 String UserName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "View User Photos",
          style: AppFonts.personalinfoAppBar,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        GradientText(
          text: UserName +"Photos",
          style: AppFonts.subscriptionBlaxityGold,
          gradient: AppColors.buttonColor,
        ).marginSymmetric(vertical: 20.h,horizontal: 20.w),
        Expanded(child: (imagesList.isNotEmpty)?GridView.builder(
          padding: EdgeInsets.all(15),
          itemCount: imagesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
          childAspectRatio: 104/163,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
          ), itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Get.to(ScreenFullImagePreview(imageUrl: imagesList[index],));
            },
            child: Container(
              width: Get.width,
              height:Get.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.chatColor
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  imagesList[index],
                  fit: BoxFit.cover,
                ),
              )
            ),
          );
        }, ):Center(child: Text("No Photos"),),),
      ],),
    );
  }

 ScreenViewUserPhotos({
   required this.imagesList,
   required this.UserName,
 });
}
