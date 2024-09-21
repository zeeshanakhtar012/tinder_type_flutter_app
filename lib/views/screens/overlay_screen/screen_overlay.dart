import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:blaxity/constants/fonts.dart';

class OverlayScreen extends StatelessWidget {

  // OverlayScreen({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .6,

      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF1D1D1D),
        border: Border.all(color: Color(0xFFA7713F)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 77.h,
            width: 98.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFA7713F)),
            ),
            child: Center(
              child: Image(image: AssetImage("assets/icons/couple_icon.png")),
            ),
          ),
          Text(
            'Swipe Profiles',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ).marginOnly(top: 6.sp),
          Text(
            textAlign: TextAlign.center,
            "Find the right Match for you based on interests and desires",
            style: AppFonts.subscriptionSubtitle,
          ).marginSymmetric(horizontal: 40.w, vertical: 10.h),
        ],
      ),
    );
  }
}
