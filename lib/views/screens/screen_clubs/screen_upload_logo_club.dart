import 'dart:io';

import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_opnening_hours_clu.dart';
import 'package:blaxity/widgets/custom_image_picker_container.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenUploadLogoClub extends StatefulWidget {
User? user;
  @override
  State<ScreenUploadLogoClub> createState() => _ScreenUploadLogoClubState();

ScreenUploadLogoClub({
    this.user,
  });
}

class _ScreenUploadLogoClubState extends State<ScreenUploadLogoClub> {
  ControllerRegistration controllerRegistration = Get.put(ControllerRegistration());
  Club ? club;
  @override
  Widget build(BuildContext context) {
    if (widget.user != null) {
      club = widget.user!.clubs!.first;
    }
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
          title: Text("3/9", style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
                text: "Upload Your logo",
                style: AppFonts.titleLogin,
                gradient: AppColors.buttonColor),
            Text("Showcase Your Brand with a Distinctive Logo", style: AppFonts.subtitle,),
            MyInputField(
              readOnly: true,
              hint: "upload logo",
            ),
            GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .1,),
              Align(
                alignment: Alignment.center,
                child: CustomImagePickerContainer(
                  onImagePicked: (value){
                    controllerRegistration.logoImage = File(value);
                  },
                  backgroundColor: Colors.transparent,
                  icon: Icons.add_circle_outline,
                  height: 300.h,
                  iconSize: 50.sp,
                  width: 300.w,
                ),
              ),
            Spacer(),
            CustomSelectbaleButton(
              onTap: (){
                if (controllerRegistration.logoImage!=null) {
                 if (widget.user==null) {
                   Get.to(ScreenOpeningHours());
                 }
                 else{
                   controllerRegistration.updateClub(club: club!, f_name: widget.user!.fName?? "Test", descrption: widget.user!.reference!.description?? "Test Decription",logo_image: controllerRegistration.logoImage, phone: widget.user!.phone?? "1234567890",);

                 }
                }
                else{
                  Get.snackbar("Error", "Please upload your logo", backgroundColor: Colors.red, colorText: Colors.white);
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
