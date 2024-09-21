import 'dart:io';

import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/screen_individual/screen_location_individual.dart';
import 'package:blaxity/widgets/custom_image_picker_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';

class ScreenUploadProfileIndividual extends StatefulWidget {
  const ScreenUploadProfileIndividual({super.key});

  @override
  _ScreenUploadProfileIndividualState createState() => _ScreenUploadProfileIndividualState();
}

class _ScreenUploadProfileIndividualState extends State<ScreenUploadProfileIndividual> {
  bool showText = false;
  ControllerRegistration controllerRegistration=Get.put(ControllerRegistration());
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
            "2/5",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text: "Upload Your Profile\nPic",
              style: AppFonts.titleLogin, gradient: AppColors.buttonColor,
            ),
            Text(
              "Showcase Your Brand with a Distinctive Picture",
              style: AppFonts.subtitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "upload profile pic",
                  style: AppFonts.subtitle,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            GradientDivider(
              gradient: AppColors.buttonColor,
              width: Get.width,
              thickness: .2,
            ),
            if (showText)
              Align(
                alignment: Alignment.center,
                  child: CustomImagePickerContainer(
                    backgroundColor: Colors.transparent,
                    height: 150.h,
                    iconSize: 44.sp,
                    onImagePicked: (value){
                      controllerRegistration.profileImage=File(value);
                    },
                    width: 200.w,
                  ),
              ),
            Spacer(),
            CustomSelectbaleButton(
              onTap: () {
               if (controllerRegistration.profileImage!=null) {
                 Get.to(ScreenLocationIndividual(step: '3 of 5',));
               }
                // Get.to(MyHomePage(key: _cscPickerKey, title: 'CSC Pikcer',));
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
