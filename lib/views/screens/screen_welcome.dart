import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/controllers/controller_payment.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_blaxiter_subscription_single_user.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_wait_list_sinlge_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_selectable_button.dart';

class ScreenWelcome extends StatelessWidget {
// UserResponse? userResponse;
  @override
  Widget build(BuildContext context) {
    ControllerHome controllerHome = Get.put(ControllerHome());
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              text: 'Welcome to',
              style: AppFonts.titleWelcome,
              gradient: AppColors.buttonColor,
            ),
            Image(
                image: AssetImage("assets/text_icons/blaxity_design.png")),
            Text(
              textAlign: TextAlign.center,
              "Pair your profile with your partner. You will appear as partners on each other’s profiles.",
              style: TextStyle(
                color: Color(0xffD0D0D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            // SizedBox(height: 35.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: GradientText(
                    text: 'Find Couples & Select Singles',
                    style: AppFonts.titleWelcome.copyWith(
                        fontSize: 17.sp, fontWeight: FontWeight.w700),
                    gradient: AppColors.buttonColor,
                  ),
                  subtitle: Text(
                    textAlign: TextAlign.start,
                    "Search based on interest, location & who’s online.",
                    style: AppFonts.subtitle.copyWith(fontSize: 14.sp,
                        color: Color(0xFFD0D0D0)
                    ),
                  ),
                  leading: Container(
                    height: 54.h,
                    width: 69.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color(0xFFA7713F)
                        )
                    ),
                    child: Center(
                      child: Image(image: AssetImage(
                          "assets/icons/couple_icon.png")),
                    ),
                  ),
                ).marginSymmetric(
                  vertical: 10.sp,
                ),
                ListTile(
                  title: GradientText(
                    text: 'Join public, private events',
                    style: AppFonts.titleWelcome.copyWith(
                        fontSize: 17.sp, fontWeight: FontWeight.w700),
                    gradient: AppColors.buttonColor,
                  ),
                  subtitle: Text(textAlign: TextAlign.start,
                    "Find exclusive events and secret parties worldwide.",
                    style: AppFonts.subtitle.copyWith(fontSize: 14.sp,
                        color: Color(0xFFD0D0D0)
                    ),
                  ),
                  leading: Container(
                    height: 54.h,
                    width: 69.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color(0xFFA7713F)
                        )
                    ),
                    child: Center(
                      child: Image(image: AssetImage(
                          "assets/icons/icon_join.png")),
                    ),
                  ),
                ).marginSymmetric(
                  vertical: 10.sp,
                ),
                ListTile(
                  title: GradientText(
                    text: 'Anonymous Audio / Video',
                    style: AppFonts.titleWelcome.copyWith(
                        fontSize: 17.sp, fontWeight: FontWeight.w700),
                    gradient: AppColors.buttonColor,
                  ),
                  subtitle: Text(
                    textAlign: TextAlign.start,
                    "Access tools to meet others in complete secrecy.",
                    style: AppFonts.subtitle.copyWith(fontSize: 14.sp,
                        color: Color(0xFFD0D0D0)
                    ),
                  ),
                  leading: Container(
                    height: 54.h,
                    width: 69.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color(0xFFA7713F)
                        )
                    ),
                    child: Center(
                      child: Image(image: AssetImage(
                          "assets/icons/chat_icon.png")),
                    ),
                  ),
                ).marginSymmetric(
                  vertical: 10.sp,
                ),
                ListTile(
                  title: GradientText(
                    text: '& Much More',
                    style: AppFonts.titleWelcome.copyWith(
                        fontSize: 17.sp, fontWeight: FontWeight.w700),
                    gradient: AppColors.buttonColor,
                  ),
                  subtitle: Text(
                    textAlign: TextAlign.start,
                    "Invite your crush couple/single, and see who liked/viewed your profile.",
                    style: AppFonts.subtitle.copyWith(fontSize: 14.sp,
                        color: Color(0xFFD0D0D0)
                    ),),
                  leading: Container(
                    height: 54.h,
                    width: 69.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color(0xFFA7713F)
                        )
                    ),
                    child: Center(
                      child: Image(image: AssetImage(
                          "assets/icons/icon_much.png")),
                    ),
                  ),
                ).marginSymmetric(
                  vertical: 10.sp,
                ),
              ],
            ).marginSymmetric(
              vertical: 20.sp,
            ),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading:controllerHome.isLoading.value,
                onTap: () async {
                  String userType = await ControllerLogin.getUserType() ?? '';
                  if (userType == "couple") {
                    Get.to(ScreenSubscription(isHome: false,));
                  }
                  else {
                    Get.offAll(ScreenWaitListSingleUser());
                  }
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Continue",
              );
            }).marginSymmetric(
              vertical: 12.h,
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }

// ScreenWelcome({
//   required this.userResponse,
// });
}
