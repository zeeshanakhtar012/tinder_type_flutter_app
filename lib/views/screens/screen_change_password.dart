import 'package:blaxity/controllers/authentication_controllers/controller_change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/my_input_feild.dart';

class ScreenChangePassword extends StatelessWidget {
  ScreenChangePassword({super.key});
  final ControllerChangePassword _changePassword = Get.put(ControllerChangePassword());

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
        body: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset password',
              style: AppFonts.titleLogin,
            ),
            Text(
              "Reset your password here",
              style: AppFonts.subtitle,
            ),
            MyInputField(
              isPasswordField: true,
              controller: _changePassword.oldPassword.value,
              hint: "Old Password",
            ).marginOnly(
              top: 15.sp,
            ),
            MyInputField(
              isPasswordField: true,
              controller: _changePassword.newPasswordController.value,
              hint: "New Password",
            ).marginOnly(
              top: 15.sp,
            ),
            MyInputField(
              isPasswordField: true,
              controller: _changePassword.confirmPasswordController.value,
              hint: "Confirm Password",
            ).marginOnly(
              top: 15.sp,
            ),
            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ),
            Spacer(),
            CustomButton(
              loading: _changePassword.isLoading.value,
              onTap: () {
                if (_changePassword.newPasswordController.value.text != _changePassword.confirmPasswordController.value.text) {
                  Get.snackbar("Error", "Password does not match.");
                } else {
                  _changePassword.changePassword();
                }
              },
              text: "CHANGE MY PASSWORD",
              textColor: Colors.white,
              buttonGradient: AppColors.buttonColor,
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        )),
      ),
    );
  }
}
