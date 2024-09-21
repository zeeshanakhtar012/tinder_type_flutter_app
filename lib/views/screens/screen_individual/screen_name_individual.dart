import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/screen_individual/screen_upload_profile_individual.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenNameIndividual extends StatelessWidget {
 ControllerRegistration _controllerRegistration=Get.put(ControllerRegistration());
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
          title: Text("1/5", style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
                text: "What shall we call\nyou?",
                style: AppFonts.titleLogin,
                gradient: AppColors.buttonColor),
           MyInputField(
             hint: "Name",
             controller: _controllerRegistration.nameController,
           ),
            GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .1,),
            Spacer(),
            CustomSelectbaleButton(
              onTap: (){
                if (_controllerRegistration.nameController.text.isNotEmpty) {
                  Get.to(ScreenUploadProfileIndividual());
                }
                else{
                  Get.snackbar("Error", "Please enter your name");
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
