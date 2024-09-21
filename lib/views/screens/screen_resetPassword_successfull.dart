import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/views/screens/screen_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_button.dart';

class ScreenPasswordSuccessfull extends StatelessWidget {
  const ScreenPasswordSuccessfull({super.key});

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.sp,
            ),
            Image(
                image: AssetImage("assets/icons/right_tick.png")),
            Text(
              "Password reset\n      succesful",
              style: AppFonts.titleSuccessFullPassword,
            ),
            Text(
                style: AppFonts.subtitle,
                "You have successfully reset your password.\nPlease use your new password when you’re logging in"),
            Spacer(),
            CustomButton(
              onTap: (){
                Get.to(ScreenCategory());
              },
              text: "Continue",
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
