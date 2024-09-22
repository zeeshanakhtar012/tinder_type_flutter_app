import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/screen_update_password.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_forgot_password.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';
import '../../../widgets/pin_put.dart';

class ScreenEmailOTP extends StatelessWidget {
  final String email;
  final String step;
  String? id,link;
  final String? verificationType; // Add this parameter

   final ControllerRegistration controllerRegistration = Get.put(ControllerRegistration());
   final ForgotPasswordController controllerResetPassword= Get.put(ForgotPasswordController());

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
            step,
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text:
              "Got our email?",
              style: AppFonts.titleLogin,
            ),
            Text("OTP will be sent to your email address for\nverification.",
                style: AppFonts.subtitle),
            // Pinput Field
            Center(
              child: PinPut(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                controller:  controllerRegistration.otpController,

                followingFieldDecoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFA7713F),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                eachFieldHeight: 65.h,
                eachFieldWidth: 65.w,
                submittedFieldDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFA7713F),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 5,
                      spreadRadius: 4,
                    )
                  ],
                ),
                selectedFieldDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFA7713F),
                  ),
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 5,
                      spreadRadius: 4,
                    )
                  ],
                ),
                cursorColor: Colors.red,
                fieldsCount: 4,
              ),
            ).marginSymmetric(
              vertical: 5.sp,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "A code has been sent to your email",
                style: AppFonts.subtitle,
              ),
            ).marginOnly(
              top: 10.h,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientWidget(
                  child: Text(
                     "Resend in ",
                    style: AppFonts.resendEmailStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),

                  ),
                ),
                Countdown(
                  seconds: 60,
                  build: (BuildContext context, double time) =>
                      GradientWidget(
                        child: Text(
                          time.toString(),
                          style: AppFonts.resendEmailStyle.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                ),
              ],
            ),
            if(verificationType == "resetPassword")
              MyInputField(
                isPasswordField: true,
                controller: controllerResetPassword.password,
                hint: "Password",
              ).marginOnly(
                top: 15.sp,
              ),
               GradientDivider(
                 thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
                ),
              MyInputField(
              isPasswordField: true,
              controller: controllerResetPassword.confirmPassword,
              hint: "Confirm Password",
              ).marginOnly(
              top: 15.sp,
              ),
              GradientDivider(
              thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
              ),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading:  controllerRegistration.isLoading.value,
                     // Use the appropriate controller
                onTap: () async {
                  if (controllerRegistration.otpController.text.isNotEmpty) {
                    if (verificationType=="resetPassword") {
                      log(verificationType.toString());
                      String opt = controllerRegistration.otpController.text;
                     await controllerResetPassword.UpdatePassword(email: email, otp: opt);
                    }  else{
                      await controllerRegistration.verifyOtp(email: email, id: id??"", link: link??"",);
                    }
                  }
                  else{
                   FirebaseUtils.showError("Please Enter OTP");
                  }

                  // Add more conditions for other OTP verification types if needed
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

  ScreenEmailOTP({
    required this.email,
    required this.step,
    this.id,
    this.link,
    this.verificationType,
  });
}
