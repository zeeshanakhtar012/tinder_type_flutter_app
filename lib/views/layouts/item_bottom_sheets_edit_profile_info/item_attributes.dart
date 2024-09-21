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

class ItemAttributesBottomSheet {

  static void show(BuildContext context, User user) {
    RxList<String> selectedOptions = <String>[].obs;
    List<String> options = [
      'Charismatic','Passionate','Sensual','Alluring','Seductive',
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        selectedOptions.value = user.reference!.attributes ?? [];
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
                      text: "Attributes", style: AppFonts.subscriptionBlaxityGold).paddingSymmetric(
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
                    top:6.h,
                  ),

                  Obx(() {
                    return CustomSelectbaleButton(
                      isLoading: controllerRegistration.isLoading.value,
                      onTap: () async {
                        if (selectedOptions.value.isNotEmpty) {
                          await controllerRegistration.updateCoupleProfile(
                              user, attributes: selectedOptions.value);
                          Get.back();
                        }
                        else {
                          FirebaseUtils.showError("Please select your hobbies.");
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
