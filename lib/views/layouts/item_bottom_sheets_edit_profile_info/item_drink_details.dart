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
import '../../screens/personal_information_screens_couple/screen_about_details_page7.dart';

class ItemDrinkDetailsBottomSheet {

  static void show(BuildContext context, User user) {
    RxString selectedOption = ''.obs;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        selectedOption.value= user.additionalInfo?.drinkingHabit ?? '';
        final ControllerRegistration controllerRegistration = Get.put(
            ControllerRegistration());

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
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
                      text: "How often do you drink?", style: AppFonts.subscriptionBlaxityGold).paddingSymmetric(
                    vertical: 6.h,
                  ),

                  Wrap(children: List.generate(
                      controllerRegistration.drinkingHabits.length,
                          (value) {
                        return Obx(() {
                          return IntrinsicWidth(
                            child: buildSelectOneOption(
                                controllerRegistration.drinkingHabits[value],
                                    () {
                                  selectedOption.value =
                                  controllerRegistration.drinkingHabits[value];
                                },
                                selectedOption.value ==
                                    controllerRegistration
                                        .drinkingHabits[value]),
                          );
                        });
                      }
                  ),),

                  Obx(() {
                    return CustomSelectbaleButton(
                      isLoading: controllerRegistration.isLoading.value,
                      onTap: () async {
                        if (selectedOption.value.isNotEmpty) {
                          await controllerRegistration.updateCoupleProfile(
                              user, drinkingHabit: selectedOption.value);
                          Get.back();
                        }
                        else {
                          FirebaseUtils.showError("Please select your how often.");
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
            );
          },
        );
      },
    );
  }
}
