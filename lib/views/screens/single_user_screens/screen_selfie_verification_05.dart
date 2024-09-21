import 'dart:io';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_camera_verification.dart';
import 'package:blaxity/widgets/custom_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../personal_information_screens_couple/screen_describe_page8.dart';

class ScreenSelfieSingleUser extends StatefulWidget {
  String step;
  User user;

  ScreenSelfieSingleUser({required this.step, required this.user});

  @override
  _ScreenSelfieSingleUserState createState() => _ScreenSelfieSingleUserState();
}

class _ScreenSelfieSingleUserState extends State<ScreenSelfieSingleUser> {

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "5/11",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [

                          SvgPicture.asset(
                              "assets/images/image_selfie_verification.svg"),
                        ],
                      ),
                      Text(
                        "Selfie Verification",
                        style: AppFonts.titleLogin,
                      ).marginSymmetric(
                        vertical: 10.sp,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "The image should be clear and have your\nface fully inside the frame.",
                        style: AppFonts.subtitle.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      Container(
                        width: Get.width,
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 15.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF1D1D1D),
                          border: Border.all(color: Color(0xFFAE7D48)),
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/icons/info.svg"),
                            Text(
                              "We delete selfies",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.sp),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "We delete all selfies once verification is complete.",
                              style: TextStyle(
                                  color: Color(0xFFD0D0D0), fontSize: 14.sp),
                            ).marginOnly(bottom: 20.h)
                          ],
                        ),
                      ).marginSymmetric(vertical: 15.h),
                      Spacer(),
                      CustomSelectbaleButton(
                        onTap: () async {

                          // Navigate to next screen
                          Get.to(ScreenCameraVerification(user: widget.user,));
                        },
                        borderRadius: BorderRadius.circular(20),
                        width: Get.width,
                        height: 54.h,
                        strokeWidth: 1,
                        gradient: AppColors.buttonColor,
                        titleButton: "Continue",
                      ),
                    ],
                  ).marginSymmetric(
                    horizontal: 15.sp,
                    vertical: 15.sp,
                  ),

                      // SizedBox(
                      //   height: Get.height * .2,
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       Center(
                      //         child: Image.file(
                      //           File(_capturedImage!.path),
                      //           width: Get.width * .44,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //       // SvgPicture.asset(
                      //       //     "assets/images/image_selfie_verification.svg"),
                      //     ],
                      //   ),
                      // ),
                      // Text(
                      //   "Selfie Verification",
                      //   style: AppFonts.titleLogin,
                      // ).marginSymmetric(
                      //   vertical: 10.sp,
                      // ),
                      // Text(
                      //   textAlign: TextAlign.center,
                      //   "The image should be clear and have your\nface fully inside the frame.",
                      //   style: AppFonts.subtitle.copyWith(
                      //     fontSize: 16.sp,
                      //   ),
                      // ),
                      // Container(
                      //   width: Get.width,
                      //   margin: EdgeInsets.symmetric(vertical: 10.h),
                      //   padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 15.h),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Color(0xFF1D1D1D),
                      //     border: Border.all(color: Color(0xFFAE7D48)),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       SvgPicture.asset("assets/icons/info.svg"),
                      //       Text(
                      //         "We delete selfies",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 24.sp),
                      //       ),
                      //       Text(
                      //         textAlign: TextAlign.center,
                      //         "We delete all selfies once verification is complete.",
                      //         style: TextStyle(
                      //             color: Color(0xFFD0D0D0), fontSize: 14.sp),
                      //       ).marginOnly(bottom: 20.h)
                      //     ],
                      //   ),
                      // ).marginSymmetric(vertical: 15.h),
                      // Spacer(),


      ),
    );
  }
}
