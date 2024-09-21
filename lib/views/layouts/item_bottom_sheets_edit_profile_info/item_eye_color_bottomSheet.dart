
import 'dart:developer';

import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/controllers/controller_update_profiles.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_passion_page9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../screens/personal_information_screens_couple/screen_about_details_page7.dart';

class ItemEyeColorBottomSheet {
  static void show(BuildContext context, User user) {
    // String selectedOption = '';
    ControllerUpdateProfile controllerUpdateProfile = Get.put(
        ControllerUpdateProfile());
    RxString selectedEyeColor = ''.obs;
    showModalBottomSheet(
      context: context, backgroundColor: Colors.black,
      builder: (BuildContext context) {
        log(user.reference!.eyeColor.toString());
        selectedEyeColor.value= user.reference?.eyeColor ?? '';
        final ControllerRegistration controllerRegistration = Get.put(
            ControllerRegistration());

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),

                        Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset("assets/icons/line.svg"))
                            .marginOnly(top: 7.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: SvgPicture.asset(
                                  "assets/icons/cross.svg")),
                        ),
                      ],
                    ),
                  ).marginSymmetric(horizontal: 20.w, vertical: 10.h
                  ),


                  GradientText(
                    text: "Eye Color",
                    style: AppFonts.subscriptionBlaxityGold,
                    gradient: AppColors.buttonColor,
                  ).paddingSymmetric(
                    vertical: 6.h,
                  ),
                  Wrap(children: List.generate(
                      controllerRegistration.eyeColors.length,
                          (value) {
                        return Obx(() {
                          return IntrinsicWidth(
                            child: buildSelectOneOption(
                                controllerRegistration.eyeColors[value],
                                    () {
                                  selectedEyeColor.value =
                                  controllerRegistration.eyeColors[value];
                                },
                                selectedEyeColor.value ==
                                    controllerRegistration.eyeColors[value]),
                          );
                        });
                      }
                  ),),

                  Obx(() {
                    return CustomSelectbaleButton(
                      isLoading: controllerRegistration.isLoading.value,
                      onTap: () async {
                        log("tee");
                         controllerRegistration.updateCoupleProfile(
                            user, eyeColor: selectedEyeColor.value);
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(20),
                      width: Get.width,
                      height: 54.h,
                      strokeWidth: 1,
                      gradient: AppColors.buttonColor,
                      titleButton: "Continue",
                    );
                  }).marginSymmetric(vertical: 20.h, horizontal: 20.w),

                ],
              ),
            );
          },
        );
      },
    );
  }
}
