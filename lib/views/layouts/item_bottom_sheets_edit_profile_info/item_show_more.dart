import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../screens/personal_information_screens_couple/screen_about_details_page7.dart';

class ItemShowMoreBottomSheet {
  static void show(BuildContext context) {
    RxString selectedOptions = "".obs;
    List<String> languageOption = ['Women', 'Man', 'Everyone'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // selectedOptions
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
                          child: SvgPicture.asset("assets/icons/line.svg"),
                        ).marginOnly(top: 7.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SvgPicture.asset("assets/icons/cross.svg"),
                          ),
                        ),
                      ],
                    ),
                  ).marginSymmetric(horizontal: 20.w, vertical: 10.h),
                  GradientText(text: "Show me", style: AppFonts.subscriptionBlaxityGold).paddingSymmetric(
                    vertical: 6.h,
                  ),
                  Wrap(
                    children: List.generate(
                      languageOption.length,
                          (value) {
                        return Obx(() {
                          return IntrinsicWidth(
                            child: buildSelectOneOption(
                              languageOption[value],
                                  () async {
                                selectedOptions.value = languageOption[value];
                                await _saveShowMeOption(languageOption[value]); // Save the selected value
                              },
                              selectedOptions.value == languageOption[value],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  CustomSelectbaleButton(
                    onTap: () async {
                      _saveShowMeOption(selectedOptions.value);
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(20),
                    width: Get.width,
                    height: 54.h,
                    strokeWidth: 1,
                    gradient: AppColors.buttonColor,
                    titleButton: "Continue",
                  ).marginSymmetric(vertical: 20.h, horizontal: 20.w),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Function to save the selected option to SharedPreferences
  static Future<void> _saveShowMeOption(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedShowMeOption', value);
  }
}
