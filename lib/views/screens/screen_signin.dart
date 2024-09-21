import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_profile.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/screen_forgot_password.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../../controllers/authentication_controllers/controller_registration.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider_gradient.dart';

class ScreenLogin extends StatelessWidget {
  ControllerRegistration _controllerRegistration = Get.put(
      ControllerRegistration());

  ScreenLogin({
    // this.email,
    // this.password,
    super.key});

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text:'Sign in',
              gradient: AppColors.buttonColor,
              style: AppFonts.titleLogin,
            ),
            Text(
              "Access your account to continue your journey",
              style: AppFonts.subtitle,
            ),
            MyInputField(
              validator: ValidationBuilder().email().maxLength(50).build(),
              controller: _controllerRegistration.emailController,
              hint: "Email",
              // onChange: (value){
              //   email = value!;
              // },
            ),
            GradientDivider(
              thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w
            ),
            MyInputField(
              validator: ValidationBuilder().maxLength(50).build(),
              controller: _controllerRegistration.passwordController,
              // onChange: (value){
              //   password = value!;
              // },
              isPasswordField: true,
              hint: "Password",
            ),
            GradientDivider(
              thickness: 0.3, gradient: AppColors.buttonColor, width: Get.width,
            ).marginSymmetric(
                horizontal: 8.w
            ),
            SizedBox(
              height: 5.h,
            ),
            InkWell(
              onTap: () {
                Get.to(ScreenForgotPassword());
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Forgot Password?",
                  style: AppFonts.subtitle,
                ),
              ),
            ),
            Spacer(),
            Obx(() {
              return CustomButton(
                loading: _controllerRegistration.isLoading.value,
                onTap: () async {
                  if (_controllerRegistration.emailController.text.isNotEmpty &&
                      _controllerRegistration.passwordController.text
                          .isNotEmpty) {
                    await _controllerRegistration.userLogin();
                  }
                  else {
                    Get.snackbar(
                        "Error", "Please enter your email and password");
                  }
                },
                text: "Sign in",
                textColor: Colors.white,
                buttonGradient: AppColors.buttonColor,
              );
            }),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }
}
