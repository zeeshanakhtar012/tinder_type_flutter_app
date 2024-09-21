import 'package:blaxity/controllers/authentication_controllers/controller_forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/my_input_feild.dart';

class ScreenUpdatePassword extends StatelessWidget {
  ScreenUpdatePassword({super.key});
  ForgotPasswordController controller = Get.put(ForgotPasswordController());
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
              isPasswordField: true,
              controller: controller.password,
              hint: "Password",
            ).marginOnly(
              top: 15.sp,
            ),
            MyInputField(
              isPasswordField: true,
              controller: controller.confirmPassword,
              hint: "Confirm Password",
            ).marginOnly(
              top: 15.sp,
            ),
            GradientDivider(
              thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
            ),
            Spacer(),
            CustomButton(
              onTap: () async {
                await controller.UpdatePassword(
                    email: controller.email.value.text);
                controller.isLoading.value;
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
