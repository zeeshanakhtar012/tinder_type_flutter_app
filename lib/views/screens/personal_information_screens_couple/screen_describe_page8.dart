import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_passion_page9.dart';
import 'package:blaxity/views/screens/screen_individual/screen_location_individual.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../widgets/custom_description_input_field.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenDescribe extends StatelessWidget {
  String step;
  User? user;
  final controllerRegister = Get.put(ControllerRegistration());

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
            step,
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GradientText(text:
            "Describe yourself",
              style: AppFonts.titleLogin,
            ),
            Text(
              "Tell us more about yourself.",
              style: AppFonts.subtitle,
            ),
            SizedBox(
              height: 30.sp,
            ),
            GradientWidget(
              child: TextFormField(
                maxLength: 180,
                maxLines: 14,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                controller: controllerRegister.describeYourselfController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                    // counter: Text(""),
                    hintText: "Describe yourself in less than 180 characters...  ",
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400)


                ),
              ),
            ),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading: controllerRegister.isLoading.value,
                onTap: () async {
                  String description = controllerRegister.describeYourselfController.text;
                  if (description.isNotEmpty) {
                    log(controllerRegister.userType.value);
                   if (controllerRegister.userType.value=="club_event_organizer") {
                     Get.to(ScreenLocationIndividual(step: '6 of 9',));
                   }
                   else{
                     if(user!=null){
                       await controllerRegister.updateDescribeYourself(user!);
                     }
                   }
                  }
                  else {
                    FirebaseUtils.showError("Please describe yourself");
                  }
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                buttonTextColor: Color(0xFF5B5B5B),
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Continue",
              );
            }),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 10.sp,
        ),
      ),
    );
  }

  ScreenDescribe({
    required this.step,
    this.user,
  });
}
