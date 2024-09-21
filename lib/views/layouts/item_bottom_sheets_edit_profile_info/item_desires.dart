import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_selectable_button.dart';

class ItemDesiresBottomSheet {

  static void show(BuildContext context, User user) {
    RxList<String> selectedOptions = <String>[].obs;
    List<String> options = [
      'Soft Swap',
      'Hard Swap',
      'Group sex',
      'Threesome',
      'Voyeurism',
      'BDSM',
      'Exhibitionism',
      'Cuckolding',
      'Bi Curious',
      'Hall Pass',
      'Secret Parties',
      'Public Play',
      'Car Play',
      'Polyamorous Relationship',
      'Gangbang',
      'Hotwing',
      'Same Room Play',
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        final ControllerRegistration controllerRegistration = Get.put(
            ControllerRegistration());
        selectedOptions.value = user.userType=="couple"?user.commonCoupleData!.desires!.toList():user.desires!.map((e)=>e.title).toList() ?? [];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        text: "Desires", style: AppFonts.subscriptionBlaxityGold).paddingSymmetric(
                      vertical: 6.h,
                    ),
                
                    CustomChipsChoice<String>(
                      options:options,
                      selectedOptions: selectedOptions,
                      onChanged: (List<String> selectedItems) {
                        setState(() {
                          selectedOptions.value = selectedItems;
                        });
                      },
                    ).marginOnly(
                      top:6.sp,
                    ),
                
                    Obx(() {
                      return CustomSelectbaleButton(
                        isLoading: controllerRegistration.isLoading.value,
                        onTap: () async {
                          if (selectedOptions.value.isNotEmpty) {
                            await controllerRegistration.updateCoupleProfile(
                                user, desires: selectedOptions.value);
                            Get.back();
                          }
                          else {
                            FirebaseUtils.showError("Please select your desires.");
                          }
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
              ),
            );
          },
        );
      },
    );
  }
}
