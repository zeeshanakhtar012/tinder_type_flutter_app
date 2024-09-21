import 'dart:developer';

import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_describe_page8.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenAboutDetails extends StatefulWidget {
  String step;
  User? user;
  String? id,link;

  @override
  State<ScreenAboutDetails> createState() => _ScreenAboutDetailsState();

  ScreenAboutDetails({
    required this.step,
    this.user,
    this.id,
    this.link,
  });
}

class _ScreenAboutDetailsState extends State<ScreenAboutDetails> {
  final controllerRegister = Get.put(ControllerRegistration());


  // Selected options


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: Text(widget.step, style: AppFonts.personalinfoAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GradientText(text: "About you", style: AppFonts.titleLogin).marginOnly(
                top: 10.h,
              ),
              Text("Tell us more about yourself", style: AppFonts.subtitle).marginOnly(
                bottom: 20.h,
              ),
              MyInputField(
                readOnly: true,
                controller: controllerRegister.eyeColorController,
                hint: "Eye Color",
                suffix: PopupMenuButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                  onSelected: (String value) {
                    controllerRegister.eyeColorController.text = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return controllerRegister.eyeColors
                        .map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                ),
              ).marginOnly(
                top: 10.h,
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
              ),
              MyInputField(
                readOnly: true,

                controller: controllerRegister.ethnicityController,

                hint: "Ethnicity",
                suffix: PopupMenuButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  onSelected: (String value) {
                    controllerRegister.ethnicityController.text = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return controllerRegister.ethnicities
                        .map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                ),
              ).marginOnly(
                top: 10.h,
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
              ),
              MyInputField(
                  controller: controllerRegister.educationController,

                  hint: "Education",
                  readOnly: true,

                  suffix: PopupMenuButton<String>(
                    icon: Icon(
                        Icons.keyboard_arrow_down, color: Colors.white),
                    onSelected: (String value) {
                      controllerRegister.educationController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return controllerRegister.educationLevels
                          .map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                  )
              ).marginOnly(
                top: 10.h,
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
              ),
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return MyInputField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: controllerRegister.languagesList.value.join(', '),
                    ),
                    hint: "Language",
                    suffix: PopupMenuButton<String>(
                      icon: Icon(
                          Icons.keyboard_arrow_down, color: Colors.white),
                      onSelected: (String value) {
                        controllerRegister.languagesList.value.add(value);
                        setState(() {});
                      },
                      itemBuilder: (BuildContext context) {
                        return controllerRegister.selectLanguages
                            .map<PopupMenuItem<String>>((String value) {
                          return PopupMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList();
                      },
                    )
                );
              },).marginOnly(
                top: 10.h,
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
              ),
              GradientText(text:
                  "How often do you drink?",
                  gradient: AppColors.buttonColor,
                  style: AppFonts.subscriptionTitle).marginOnly(
                top: 10.h,
              ),
              Wrap(children: List.generate(
                  controllerRegister.drinkingHabits.length,
                      (value) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: buildSelectOneOption(
                            controllerRegister.drinkingHabits[value],
                                () {
                              controllerRegister.howOftenDrink.value =
                              controllerRegister.drinkingHabits[value];
                            },
                            controllerRegister.howOftenDrink.value ==
                                controllerRegister.drinkingHabits[value]),
                      );
                    });
                  }
              ),),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                vertical: 12.h
              ),
              GradientText(
                  gradient: AppColors.buttonColor,
                  text:
                  "How often do you smoke?", style: AppFonts.subscriptionTitle).marginOnly(
                top: 10.h,
              ),
              Wrap(children: List.generate(

                  controllerRegister.smokingHabits.length,
                      (value) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: buildSelectOneOption(
                            controllerRegister.smokingHabits[value],
                                () {
                              controllerRegister.howOftenSmoke.value =
                              controllerRegister.smokingHabits[value];
                            },
                            controllerRegister.howOftenSmoke.value ==
                                controllerRegister.smokingHabits[value]),
                      );
                    });
                  }
              )),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                vertical: 12.h,
                horizontal: 8.w,
              ),
              GradientText(text:
                  "What is your Body Type?", style: AppFonts.subscriptionTitle,
              gradient: AppColors.buttonColor,
              ).marginOnly(
                top: 10.h,
              ),
              Wrap(children: List.generate(

                  controllerRegister.bodyTypes.length,
                      (value) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: buildSelectOneOption(
                            controllerRegister.bodyTypes[value],
                                () {
                              controllerRegister.selectBodyType.value =
                              controllerRegister.bodyTypes[value];
                            },
                            controllerRegister.selectBodyType.value ==
                                controllerRegister.bodyTypes[value]),
                      );
                    });
                  }
              )),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                vertical: 12.h,
              ),
              GradientText(text: "Safety Practices",
                  gradient: AppColors.buttonColor,
                  style: AppFonts.subscriptionTitle).marginOnly(
                top: 10.h,
              ),
              Wrap(children:
              List.generate(
                  controllerRegister.safetyMeasures.length,
                      (value) {
                    return Obx(() {
                      return IntrinsicWidth(
                        child: buildSelectOneOption(
                            controllerRegister.safetyMeasures[value],
                                () {
                              controllerRegister.selectSafetyMeasures.value =
                              controllerRegister.safetyMeasures[value];
                            },
                            controllerRegister.selectSafetyMeasures.value ==
                                controllerRegister.safetyMeasures[value]),
                      );
                    });
                  }
              )
                ,),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                vertical: 12.h,
              ),
              Obx(() {
                return CustomSelectbaleButton(
                  isLoading: controllerRegister.isLoading.value,
                  onTap: () async {
                    log("Eye${controllerRegister.eyeColorController.text}");
                    log("Ethnicity${controllerRegister.ethnicityController
                        .text}");
                    log("Language${controllerRegister.languagesList.value}");
                    log("Education${controllerRegister.educationController
                        .text}");
                    log("Body${controllerRegister.selectBodyType.value}");
                    log("Smoke${controllerRegister.howOftenSmoke.value}");
                    log("Drink${controllerRegister.howOftenDrink.value}");
                    log("Safety${controllerRegister.selectSafetyMeasures
                        .value}");


                    if (controllerRegister.selectSafetyMeasures.value
                        .isNotEmpty &&
                        controllerRegister.selectBodyType.value.isNotEmpty &&
                        controllerRegister.howOftenDrink.value.isNotEmpty &&
                        controllerRegister.howOftenSmoke.value.isNotEmpty &&
                        controllerRegister.languagesList.value.isNotEmpty &&
                        controllerRegister.educationController.text
                            .isNotEmpty &&
                        controllerRegister.eyeColorController.text.isNotEmpty &&
                        controllerRegister.ethnicityController.text.isNotEmpty
                    ) {
                      await controllerRegister.updateAboutDetails(widget.user!,widget.id??"",widget.link??'');
                    }
                    else {
                      FirebaseUtils.showError(
                          "Please fill all the required fields.");
                       }
                  },
                  borderRadius: BorderRadius.circular(20),
                  width: Get.width,
                  height: 54.h,
                  strokeWidth: 1,
                  gradient: AppColors.buttonColor,
                  titleButton: "Continue",
                );
              }).marginSymmetric(vertical: 12.h),
            ],
          ).marginSymmetric(horizontal: 15.w, vertical: 15.h),
        ),
      ),
    );
  }


}
 Widget buildSelectOneOption(String label, VoidCallback onTap,
bool isSelected) {
return GestureDetector(
onTap: onTap,
child: Container(
margin: EdgeInsets.all(6.sp),
padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
decoration: BoxDecoration(
border: Border.all(
color: isSelected ? Colors.transparent : Colors.white, width: 1),
borderRadius: BorderRadius.circular(20),
gradient: isSelected ? AppColors.buttonColor : null,
color: isSelected ? null : Colors.transparent,
),
child: Text(label, style: AppFonts.subtitleImagePickerButtonColor),
),
);
}