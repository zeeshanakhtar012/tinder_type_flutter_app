import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/fonts.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenStayConnectedSingleUser extends StatelessWidget {
 String step;
 User user;
  ScreenStayConnectedSingleUser({required this.step, required this.user});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
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
          title: Text(step, style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/icon_notification_large.svg").marginOnly(
              top: 30.sp,
            ),
            Text("Stay Connected", style: AppFonts.titleLogin,),
            Text("Receive Match and Message Notifications", style: AppFonts.subtitle,),
            Spacer(),            CustomSelectbaleButton(


              onTap: (){
                Get.to(ScreenAddPhotos(step: '11 of 11',user: user,));
              },
              borderRadius: BorderRadius.circular(20),
              width: Get.width,
              height: 54.h,
              isSelected: true,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Allow",
            ).marginSymmetric(vertical: 10.h),


            CustomSelectbaleButton(
              onTap: (){
                Get.to(ScreenAddPhotos(step: '11 of 11',user: user,));
              },
              borderRadius: BorderRadius.circular(20),
              width: Get.width,
              height: 54.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Not now",
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }


}
