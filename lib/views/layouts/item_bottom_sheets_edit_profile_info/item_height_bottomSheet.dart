import 'dart:developer';
import 'dart:ffi';

import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';

import '../../../widgets/custom_selectable_button.dart';

class ItemHeightBottomSheet {
  static void show(BuildContext context,User user) {
    final controllerRegister = Get.put(ControllerRegistration());
    final List<String> heights = [
      '0\' 0"',
      '0\' 1"',
      '0\' 2"',
      '0\' 3"',
      '0\' 4"',
      '0\' 5"',
      '0\' 6"',
      '0\' 7"',
      '0\' 8"',
      '0\' 9"',
      '0\' 10"',
      '0\' 11"',
      '1\' 0"',
      '1\' 1"',
      '1\' 2"',
      '1\' 3"',
      '1\' 4"',
      '1\' 5"',
      '1\' 6"',
      '1\' 7"',
      '1\' 8"',
      '1\' 9"',
      '1\' 10"',
      '1\' 11"',
      '2\' 0"',
      '2\' 1"',
      '2\' 2"',
      '2\' 3"',
      '2\' 4"',
      '2\' 5"',
      '2\' 6"',
      '2\' 7"',
      '2\' 8"',
      '2\' 9"',
      '2\' 10"',
      '2\' 11"',
      '3\' 0"',
      '3\' 1"',
      '3\' 2"',
      '3\' 3"',
      '3\' 4"',
      '3\' 5"',
      '3\' 6"',
      '3\' 7"',
      '3\' 8"',
      '3\' 9"',
      '3\' 10"',
      '3\' 11"',
      '4\' 0"',
      '4\' 1"',
      '4\' 2"',
      '4\' 3"',
      '4\' 4"',
      '4\' 5"',
      '4\' 6"',
      '4\' 7"',
      '4\' 8"',
      '4\' 9"',
      '4\' 10"',
      '4\' 11"',
      '5\' 0"',
      '5\' 1"',
      '5\' 2"',
      '5\' 3"',
      '5\' 4"',
      '5\' 5"',
      '5\' 6"',
      '5\' 7"',
      '5\' 8"',
      '5\' 9"',
      '5\' 10"',
      '5\' 11"',
      '6\' 0"',
      '6\' 1"',
      '6\' 2"',
      '6\' 3"',
      '6\' 4"',
      '6\' 5"',
      '6\' 6"',
      '6\' 7"',
      '6\' 8"',
      '6\' 9"',
      '6\' 10"',
      '6\' 11"',
      '7\' 0"',
      '7\' 1"',
      '7\' 2"',
      '7\' 3"',
      '7\' 4"',
      '7\' 5"',
      '7\' 6"',
      '7\' 7"',
      '7\' 8"',
      '7\' 9"',
      '7\' 10"',
      '7\' 11"',
      '8\' 0"',
      '8\' 1"',
      '8\' 2"',
      '8\' 3"',
      '8\' 4"',
      '8\' 5"',
      '8\' 6"',
      '8\' 7"',
      '8\' 8"',
      '8\' 9"',
      '8\' 10"',
      '8\' 11"',
      '9\' 0"',
      '9\' 1"',
      '9\' 2"',
      '9\' 3"',
      '9\' 4"',
      '9\' 5"',
      '9\' 6"',
      '9\' 7"',
      '9\' 8"',
      '9\' 9"',
      '9\' 10"',
      '9\' 11"',


    ];
    int selectedHeightIndex = 17;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        log(user.reference!.height.toString());

        selectedHeightIndex=heights.indexOf(user.reference!.height??'');
        log(selectedHeightIndex.toString());
        final ControllerRegistration controllerRegistration = Get.put(ControllerRegistration());
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
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
                          child: SvgPicture.asset("assets/icons/line.svg")).marginOnly(top: 7.h),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: SvgPicture.asset("assets/icons/cross.svg")),
                      ),
                    ],
                  ),
                ).marginSymmetric(horizontal: 20.w,vertical: 10.h
                ),
                GradientText(text: "How tall are you", style: AppFonts.subscriptionBlaxityGold).paddingSymmetric(
                  vertical: 6.h,
                ),
                Container(
                  height: 250,
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Stack(
                    children: [
                      CupertinoPicker(
                        backgroundColor: Colors.black,
                        itemExtent: 70.0,
                        scrollController: FixedExtentScrollController(
                            initialItem: selectedHeightIndex),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            selectedHeightIndex = index;
                          });
                          controllerRegister.height.value =
                          heights[selectedHeightIndex];
                        },
                        children: heights.map((String height) {
                          return Center(
                            child: Text(
                              height,
                              style: TextStyle(color: Colors.white,
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        top: 80.h,
                        left: 0.0,
                        right: 0.0,
                        child: GradientDivider(gradient: AppColors.buttonColor, width: Get.width,),
                      ),
                      Positioned(
                        bottom: 80.h,
                        left: 0.0,
                        right: 0.0,
                        child: GradientDivider(gradient: AppColors.buttonColor, width: Get.width,)
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return CustomSelectbaleButton(
                    isLoading: controllerRegister.isLoading.value,
                    onTap: () async {
                      if (controllerRegister.height.value.isNotEmpty) {
                        await controllerRegister.updateCoupleProfile(user,height: controllerRegister.height.value);
                        Get.back();
                      }
                      else {
                        FirebaseUtils.showError( "Please select your height.");}
                    },
                    borderRadius: BorderRadius.circular(20),
                    width: Get.width,
                    height: 54.h,
                    strokeWidth: 1,
                    gradient: AppColors.buttonColor,
                    titleButton: "Continue",
                  );
                }).marginSymmetric(vertical: 20.h,horizontal: 20.w),
              ],
            );
          },
        );
      },
    );
  }
}
