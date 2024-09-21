import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/views/layouts/item_event/event_button/item_event.dart';
import 'package:blaxity/views/screens/screen_category.dart';
import 'package:blaxity/views/screens/screen_signin.dart';
import 'package:blaxity/widgets/custom_button.dart';
import 'package:blaxity/widgets/custom_splash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_selectable_button.dart';
import '../home_page/home_layouts/layout_profile.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ControllerHome controllerHome = Get.put(ControllerHome());
    // controllerHome.fetchUserInfo();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              // fit: BoxFit.fitHeight,
              image: AssetImage("assets/images/splash_image.png")
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Image.asset(
                  height: 50.h,
                  "assets/images/balxity-splash.png"),
              Text(
                "Join our Platform where Personalities Spark Flames, Not Profile Pictures.",
                style: AppFonts.subtitle.copyWith(fontSize: 16.sp),
              ),

              CustomSplashButton(
                buttonTextColor: Colors.white,
                borderRadius: BorderRadius.circular(20.r),

                onTap: (){
                  Get.to(ScreenCategory());
                },
                  titleButton : "Create account",
                 isSelected: false, width: Get.width, height: 54.h, strokeWidth: 1, gradient: AppColors.buttonColor ,

              ).marginOnly(
                top: 30.h,
              ),
              CustomButton(
                margin: EdgeInsets.only(top: 10.h),
                text: "Sign in",
                textColor: Colors.white,
                isRound: true,
                onTap: (){
                  Get.to(ScreenLogin());
                  // Get.to(LayoutProfile());
                },
              ).marginSymmetric(
                vertical: 10.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
