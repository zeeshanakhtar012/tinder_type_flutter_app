import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/SettingController.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_partner_page1.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_name_club.dart';
import 'package:blaxity/views/screens/screen_individual/screen_name_individual.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_name_single_user.dart';
import 'package:blaxity/widgets/custom_selectable_button.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../layouts/item_category.dart';

class ScreenCategory extends StatelessWidget {
  ControllerRegistration controllerRegister =
  Get.put(ControllerRegistration());

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.put(SettingController());
    settingController.fetchSettings();
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/icons/arrow_back.svg"),
          ),
          title: Image.asset(
            "assets/text_icons/blaxity_2x.png",
            height: 50.h,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              text: "Sign Up",
              style: AppFonts.subscriptionBlaxityGold,
              gradient: AppColors.buttonColor,
            ),
            CustomSelectbaleButton(
              onTap: () {
                controllerRegister.userType.value = "couple";
                Get.to(ScreenChoosePartner());
              },
              width: Get.width,
              height: 54.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Couple",
              borderRadius: BorderRadius.circular(20.r),
              isSelected: true,
            ).marginOnly(top: 10.h, bottom: 30.h),
            SizedBox(
                width: Get.width * .5, child: GradientWidget(child: Divider())),
            GradientText(
              text: "Event Organizer",
              style: AppFonts.subscriptionBlaxityGold,
              gradient: AppColors.buttonColor,
            ).marginSymmetric(vertical: 10.h),
            Obx(() {
              return (settingController.isShowClub.value == true)? comingSoonButton("Club"): CustomSelectbaleButton(
                onTap: () {
                  controllerRegister.userType.value = "club_event_organizer";
                  Get.to(ScreenAddNameClub());
                },
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Club",
                borderRadius: BorderRadius.circular(20.r),
                isSelected: true,
              );
            }).marginSymmetric(vertical: 7.h),

            Obx(() {
              return settingController.isShowClub.value == true
                  ? comingSoonButton("Individual Organizer")
                  : CustomSelectbaleButton(
                onTap: () {
                  controllerRegister.userType.value =
                  "individual_event_organizer";
                  Get.to(ScreenNameIndividual());
                },
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Individual Organizer",
                borderRadius: BorderRadius.circular(20.r),
                isSelected: true,
              );
            }).marginOnly(top: 7.h, bottom: 30.h),
            SizedBox(
                width: Get.width * .5, child: GradientWidget(child: Divider())),
            GradientText(
              text: "Approval Only",
              style: AppFonts.subscriptionBlaxityGold,
              gradient: AppColors.buttonColor,
            ).marginSymmetric(vertical: 10.h),
            CustomSelectbaleButton(
              onTap: () {
                controllerRegister.userType.value = "single";
                Get.to(ScreenSingleUserName());
              },
              width: Get.width,
              height: 54.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Single",
              borderRadius: BorderRadius.circular(20.r),
              isSelected: true,
            ).marginSymmetric(vertical: 7.h),
            // ItemCategory(
            //   onTap: () {
            //
            //   },
            //   borderRadius: BorderRadius.circular(20),
            //   width: width,
            //   height: 54.h,
            //   strokeWidth: 1,
            //   gradient: AppColors.buttonColor,
            //   child: Text("Find me passion"),
            // ).marginSymmetric(
            //   vertical: 20.sp,
            // ),
            // Text(
            //   "Couple",
            //   style: AppFonts.subscriptionBlaxityGold,
            // ),
            // Text(
            //   "Make connection and discover local groups and\nevents.",
            //   style: AppFonts.resendEmailStyle,
            // ),
            //
            // // ItemCategory(
            // //   onTap: (){
            // //     Get.to(ScreenNameIndividual());
            // //   },
            // //   borderRadius: BorderRadius.circular(20),
            // //   width: width,
            // //   height: 54.h,
            // //   strokeWidth: 1,
            // //   gradient: AppColors.buttonColor,
            // //   child: Text("Individual Organizer"),
            // // ).marginSymmetric(
            // //   vertical: 10.sp,
            // // ),
            // Text(
            //   "Are you a Club or Individual\nOrganizer",
            //   style: AppFonts.subscriptionBlaxityGold,
            // ),
            // Text(
            //   "Describe your organization and attract your\nconnections.",
            //   style: AppFonts.resendEmailStyle,
            // ),
            // ItemCategory(
            //   onTap: () {
            //     controllerRegister.userType.value = "club_event_organizer";
            //     Get.to(ScreenAddNameClub());
            //   },
            //   borderRadius: BorderRadius.circular(20),
            //   width: width,
            //   height: 54.h,
            //   strokeWidth: 1,
            //   gradient: AppColors.buttonColor,
            //   child: Text("Club"),
            // ).marginSymmetric(
            //   vertical: 10.sp,
            // ),
            // ItemCategory(
            //   onTap: () {
            //
            //   },
            //   borderRadius: BorderRadius.circular(20),
            //   width: width,
            //   height: 54.h,
            //   strokeWidth: 1,
            //   gradient: AppColors.buttonColor,
            //   child: Text("Individual"),
            // ).marginSymmetric(
            //   vertical: 10.sp,
            // ),
          ],
        ).marginSymmetric(horizontal: 20.w, vertical: 50.h),
      ),
    );
  }

  Widget comingSoonButton(String text) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: Get.width,
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                  width: 1,
                  color: Color(0xFFC09960)
              ),
              color: AppColors.chatColor
          ),
          child: Text(text, style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),),
        ),
        Positioned(
            bottom: 5.h,
            right: 20.w,
            child: Text("Coming Soon", style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFFC09960)
            ))),
      ],
    );
  }
}
