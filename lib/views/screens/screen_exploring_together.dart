import 'dart:developer';

import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/screen_welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/colors.dart';
import '../../constants/firebase_utils.dart';
import '../../constants/fonts.dart';
import '../../controllers/controller_home.dart';
import '../../models/user.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/custom_selectable_button.dart';

class ScreenExploring extends StatelessWidget {
  User user;
  ControllerRegistration controllerRegistration = Get.put(
      ControllerRegistration());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              top: 30.sp
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image(image: AssetImage(
                  "assets/images/exploring_png.png")).marginOnly(top: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: 'Exploring together?',
                  style: AppFonts.titleLogin,
                  gradient: AppColors.buttonColor,
                ),
              ).marginOnly(top: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pair your profile with your partner. You will\nappear as partners on each other’s profiles.",
                  style: TextStyle(
                    color: Color(0xffD0D0D0),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ).marginOnly(top: 6.h),

              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // controllerRegistration.createDynamicLink();
                      controllerRegistration.link.value = await controllerRegistration.createDynamicLink();
                      Share.share(controllerRegistration.link.value);
                      await controllerRegistration.updateQrCodeAndShareLink();


                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            height: 23.88.h,
                            width: 23.88.w,
                            "assets/icons/icon_share_svg_gold.svg"),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text("Share link", style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),),
                      ],
                    ).paddingSymmetric(
                      vertical: 8.sp,
                      horizontal: 15.w,
                    ),
                  ),
                  GradientDivider(
                    thickness: 0.3,
                    gradient: AppColors.buttonColor,
                    width: width,
                  ).paddingSymmetric(
                    vertical: 6.sp,
                    horizontal: 15.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      controllerRegistration.generatedQACode.value =
                      await controllerRegistration.createDynamicLink();
                      log("qr code ${controllerRegistration.generatedQACode.value}");
                      await controllerRegistration.updateQrCodeAndShareLink();

                    },
                    child: Row(
                      children: [
                        Image.asset("assets/icons/icon_qr.png",height: 23.88.h,
                          width: 23.88.w,),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("Generate QR code", style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),),
                      ],
                    ),
                  ).paddingSymmetric(
                    vertical: 8.sp,
                    horizontal: 15.w,
                  ),
                  GradientDivider(
                    thickness: 0.3,
                    gradient: AppColors.buttonColor,
                    width: width,
                  ).paddingSymmetric(
                    vertical: 6.sp,
                    horizontal: 15.w,
                  ),

                  Obx(() {
                    return (controllerRegistration.generatedQACode.isNotEmpty)?QrImageView(
                      data: controllerRegistration.generatedQACode.value,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: AppColors.chatColor,
                      foregroundColor: Colors.white,
                      gapless: false,
                    ):SizedBox();
                  }).marginSymmetric(vertical: 10.h),
                ],
              ).marginSymmetric(
                vertical: 20.sp,
              ),
              Spacer(),
              // Obx(() {
              //   return CustomSelectbaleButton(
              //     isLoading: controllerRegistration.isLoading.value,
              //     onTap: () {
              //       controllerRegistration.updateQrCodeAndShareLink();
              //       // Get.to(ScreenAddPhotos());
              //     },
              //     borderRadius: BorderRadius.circular(20),
              //     width: Get.width,
              //     height: 54.h,
              //     strokeWidth: 1,
              //     gradient: AppColors.buttonColor,
              //     titleButton: "Scan",
              //     imageUrl: "assets/icons/qr_scan.png",
              //   );
              // }).marginSymmetric(
              //   vertical: 12.h,
              // ),
              CustomSelectbaleButton(
                isLoading: controllerRegistration.isLoading.value,
                onTap: () async {
                 if (user.userType=="couple") {
                   ControllerHome controllerHome = Get.put(ControllerHome());
                   UserResponse userResponse = await Get.find<ControllerHome>().fetchUserProfile();
                   if (userResponse.has_couple == "1") {
                     Get.to(ScreenWelcome());
                   }
                   else{
                     FirebaseUtils.showError( "Please wait for your partner to add you to their profile.");
                   }
                 }
                 else{
                   Get.to(ScreenWelcome());
                 }
                  // Get.to(ScreenAddPhotos());
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Continue",
              ).marginSymmetric(
                vertical: 12.h,
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
        ),
      ),
    );
  }

  ScreenExploring({
    required this.user,
  });
}
