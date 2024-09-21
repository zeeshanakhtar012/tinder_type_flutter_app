import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_email_otp_page10.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenChooseEmail extends StatelessWidget {
   String step;
   String? id,link;

  final controllerRegister = Get.find<ControllerRegistration>();

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
            step,
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text: 
              "What is your email\naddress?",
              style: AppFonts.titleLogin, gradient: AppColors.buttonColor,
            ),
            Text(
              "This will be your registered address for\nimportant communications..",
              style: AppFonts.subtitle.copyWith(fontSize: 16.sp,
              fontWeight: FontWeight.w400),
            ),
            MyInputField(
              validator: ValidationBuilder().email().maxLength(50).build(),
              controller: controllerRegister.emailController,
              hint: "Email Address",
            ),
            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w,
            ),
            MyInputField(
              validator: ValidationBuilder().maxLength(50).build(),
              isPasswordField: true,
              controller: controllerRegister.passwordController,
              hint: "Password",
            ),
            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w,
            ),
            MyInputField(
              isPasswordField: true,
              validator: ValidationBuilder().maxLength(50).build(),
              controller: controllerRegister.passwordConfirmationController,
              hint: "confirm Password",
            ),
            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w,
            ),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading: controllerRegister.isLoading.value,
                onTap: () async {
                  if (id!=null) {
                    controllerRegister.userType.value = "couple";

                  }
                  log(controllerRegister.userType.value.toString());

                  if (controllerRegister.emailController.text.isNotEmpty &&
                      controllerRegister.passwordController.text.isNotEmpty &&
                      controllerRegister
                          .passwordConfirmationController.text.isNotEmpty&&controllerRegister.passwordController.text==controllerRegister.passwordConfirmationController.text) {
                    // await controllerRegister.userRegistration();
                    //
                    if (controllerRegister.userType.value == "couple") {
                      if (id==null) {
                        await controllerRegister.userRegistration();
                      }
                      else{
                        log(link.toString());
                        log(id.toString());

                        await controllerRegister.partnerTwoRegistration(link!,id!);
                      }
                    } else if (controllerRegister.userType.value == "single") {
                      await controllerRegister.singleRegistration();
                    } else if (controllerRegister.userType.value ==
                        "club_event_organizer") {
                      await controllerRegister.registerClub();
                    } else if (controllerRegister.userType.value ==
                        "individual_event_organizer") {
                    await  controllerRegister.registerIndividualVerification();

                    } else {
                      Get.snackbar("Alert", "Please choose user type",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  }
                  else {
                    FirebaseUtils.showError("Please Enter Email and Password or make sure you enter same password");
                  }
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Continue",
              );
            }),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 10.sp,
        ),
      ),
    );
  }

   ScreenChooseEmail({
    required this.step,
    this.id,
    this.link,
  });
}
