import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_date_of_birth3.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_email_page4.dart';
import 'package:blaxity/widgets/custom_toggle_switch.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/custom_switch_gender.dart';

class ScreenSingleUserName extends StatelessWidget {
 ControllerRegistration controllerRegister = Get.find<ControllerRegistration>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            "1/11",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text:"What shall we call\nyou?", style: AppFonts.titleLogin,
            gradient: AppColors.buttonColor,
            ),
            MyInputField(
              hint: "Your name",
              controller: controllerRegister.nameController,
            ),
            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomSwitchGenderButton(onGenderChanged: (value ) {
                controllerRegister.selectGender.value = value;
              }, selectedGender: controllerRegister.selectGender.value,).marginOnly(
                top: 10.h,
              ),
            ),
            Spacer(),
            CustomSelectbaleButton(
              onTap: () {
               if (controllerRegister.nameController.text.isNotEmpty) {
                 log(controllerRegister.userType.value);
                 Get.to(ScreenChooseDate(step: '2 of 11',));
               }
               else{
                 FirebaseUtils.showError("Please Enter Your Name");
                 }
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
      ),
    );
  }
}
