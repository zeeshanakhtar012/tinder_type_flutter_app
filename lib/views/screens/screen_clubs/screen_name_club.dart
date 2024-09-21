import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_add_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';

class ScreenAddNameClub extends StatelessWidget {
   ScreenAddNameClub({super.key});
 ControllerRegistration controllerRegistration = Get.put(ControllerRegistration());
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
          title: Text("1/9", style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
                text: "Please Enter Club Name",
                style: AppFonts.titleLogin,
                gradient: AppColors.buttonColor),
            MyInputField(
              hint: "Club Name",
              controller: controllerRegistration.clubNameController,
            ),
            GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .1,),
            Spacer(),
            CustomSelectbaleButton(
              onTap: (){
               if (controllerRegistration.clubNameController.text.isNotEmpty) {
                 Get.to(ScreenAddPhoneNumberClub());
               }
               else{
                 Get.snackbar("Error", "Please enter your Club name", backgroundColor: Colors.red, colorText: Colors.white);
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
