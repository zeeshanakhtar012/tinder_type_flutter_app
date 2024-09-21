import 'package:blaxity/views/screens/screen_reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/authentication_controllers/controller_forgot_password.dart';
import '../../widgets/custom_button.dart';
import '../layouts/item_forgotPassword/item_forgot_password.dart';

class ScreenForgotPassword extends StatelessWidget {
  ScreenForgotPassword({super.key});

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

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
        ),
        body: Obx(
              () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password?',
                style: AppFonts.titleLogin,
              ),
              Text(
                "Select which contact details should we use\nto reset your password",
                style: AppFonts.subtitle,
              ),
              ItemForgotPassowrd(
                onTap: () => controller.selectOption(SelectedOption.sms),
                isSelected: controller.selectedOption.value == SelectedOption.sms,
                width: Get.width,
                borderRadius: BorderRadius.circular(10.sp),
                strokeWidth: 1.5,
                gradient: AppColors.buttonColor,
                child: ListTile(
                  title: Text("Via sms:", style: AppFonts.forgotScrItem),
                  leading: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: Icon(
                      Icons.textsms,
                      size: 24,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Container(
                          width: 5.sp,
                          height: 5.sp,
                          margin: EdgeInsets.symmetric(horizontal: 2.sp),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      SizedBox(width: 5.sp),
                      for (int i = 0; i < 4; i++)
                        Container(
                          width: 5.sp,
                          height: 5.sp,
                          margin: EdgeInsets.symmetric(horizontal: 2.sp),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      SizedBox(width: 5.sp),
                      Text(
                        "1234",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ).marginSymmetric(vertical: 5.sp),
              ItemForgotPassowrd(
                onTap: () => controller.selectOption(SelectedOption.email),
                isSelected: controller.selectedOption.value == SelectedOption.email,
                width: Get.width,
                borderRadius: BorderRadius.circular(10.sp),
                strokeWidth: 1.5,
                gradient: AppColors.buttonColor,
                child: ListTile(
                  title: Text("Via email:", style: AppFonts.forgotScrItem),
                  leading: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: Icon(
                      Icons.email,
                      size: 24,
                    ),
                  ),
                  subtitle: Text(
                    "abcd@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ).marginSymmetric(vertical: 5.sp),
              Spacer(),
              CustomButton(
                text: "Continue",
                textColor: Colors.white,
                buttonGradient: AppColors.buttonColor,
                onTap: () {
                  if (controller.selectedOption.value == SelectedOption.none) {
                    Get.snackbar('Error!', "Please select one option");
                  } else {
                    Get.to(ScreenResetNewPasswrod());
                  }
                },
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }
}
