import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_upload_logo_club.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';

class ScreenAddPhoneNumberClub extends StatelessWidget {
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
          title: Text("2/9", style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
                text: "What’s your phone\nnumber?",
                style: AppFonts.titleLogin,
                gradient: AppColors.buttonColor),
            Text("We’ll send a verification code to this number.", style: AppFonts.subtitle,),
            MyInputField(
              hint: "70 000 000",
              keyboardType: TextInputType.number,
              controller: controllerRegistration.clubPhoneController,
              prefix: CountryCodePicker(
                boxDecoration: BoxDecoration(
                  gradient: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
                onChanged: (value) {

                  controllerRegistration.countryCode.value = value.dialCode.toString();
                },
                textStyle: TextStyle(
                    fontSize: 14.sp, fontFamily: "Arial",color: Colors.white),
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'FR',
                favorite: ['+961', 'LB'],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ).paddingOnly(
                bottom: 3.h,
              ),
            ),
            GradientDivider(gradient: AppColors.buttonColor, width: Get.width, thickness: .1,),
            Spacer(),
            CustomSelectbaleButton(
              onTap: (){
               if (controllerRegistration.clubPhoneController.text.isNotEmpty) {
                 Get.to(ScreenUploadLogoClub());
               }
               else{
                 Get.snackbar("Error", "Please enter your phone number", backgroundColor: Colors.red, colorText: Colors.white);

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
