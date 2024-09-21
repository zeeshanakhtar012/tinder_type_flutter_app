import 'package:blaxity/controllers/authentication_controllers/controller_forgot_password.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_email_otp_page10.dart';
import 'package:blaxity/views/screens/screen_resetPassword_successfull.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider_gradient.dart';

class ScreenResetNewPasswrod extends StatelessWidget {
  ScreenResetNewPasswrod({super.key});
  ForgotPasswordController controller =  Get.put(ForgotPasswordController());
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
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 'Reset password',
              style: AppFonts.titleLogin,
            ),
            Text(
              "Reset your password here",
              style: AppFonts.subtitle,
            ),
            MyInputField(
              controller: controller.email.value,
              hint: "Email",
            ).marginOnly(
              top: 15.sp,
            ),
            GradientDivider(
              thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
            ),
            Spacer(),
            CustomButton(
              onTap: () async {
                await controller.GetOtp();
                await controller.isLoading.value;
                Get.to(ScreenEmailOTP(
                    verificationType: 'resetPassword',
                    step: "", email: controller.email.value.text));
              },
              text: "RESET MY PASSWORD",
              textColor: Colors.white,
              buttonGradient: AppColors.buttonColor,
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
