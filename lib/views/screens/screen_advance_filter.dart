import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/users_controllers/controller_get_user_all_data.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_about_details_page7.dart';
import 'package:blaxity/widgets/custom_button.dart';
import 'package:blaxity/widgets/custom_selectable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/authentication_controllers/controller_registration.dart';
import '../../main.dart';
import '../../widgets/custom_chip_choice.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/my_input_feild.dart';

class ScreenAdvanceFilter extends StatelessWidget {
  const ScreenAdvanceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> optionDesires = [
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
    List<String> optionParties = [
      'Ice Breaker Parties',
      'Masquerade',
      'Greedy Girl',
      'Voyeur Party',
      'Menage a Trois',
      'Black Ring Party',
      'Glow Party',
      'Key Party',
      'Swinger Resort',
      'Swinger Cruise',
      'House Party',
      'Meet & Greet'
    ];
    List<String> optionLookingFor = [
      'Explore',
      'Threeway FMM',
      'Threeway FMF',
      'Singles',
      'Group',
      'Couples',
    ];

    List<String> optionsHobbies = [
      'Concerts',
      'Yoga',
      'Coffee',
      'Climbing',
      'TV',
      'Board Games',
      'Photography',
      'Travel',
      'Dance',
      'Reading',
      'Movie',
      'Fitness',
      'Restaurants',
    ];
    var country = Rx<String?>(null);
    TextEditingController ageController = TextEditingController();
    TextEditingController genderController = TextEditingController();

    List<String> drinkingHabits = [
      'Not for me',
      'Most nights',
      'Sober curious',
      'Socially, at the weekend',
      'On special occasions',
    ];

    List<String> smokingHabits = [
      'Non-smoker',
      'Smoker',
      'Social smoker',
      'Special Smoker',
      'Trying to quit',
    ];

    List<String> eyeColors = [
      'Amber',
      'Blue',
      'Brown',
      'Gray',
      'Green',
      'Hazel',
    ];

    List<String> ethnicities = [
      'Caucasian',
      'Native American',
      'Middle Eastern',
      'Latino',
      'Asian',
    ];

    List<String> educationLevels = [
      'High School Diploma',
      'Bachelor’s Degree',
      'Master’s Degree',
      'Doctorate Degree',
    ];

    List<String> selectLanguages = [
      'Arabic',
      'Mandarin',
      'French',
      'Spanish',
      'English',
    ];

    List<String> bodyTypes = [
      'Skinny',
      'Curvy',
      'Muscular',
      'Athletic',
      'Average',
      'Heavyset',
    ];

    List<String> safetyMeasures = [
      'Always',
      'Sometimes',
      'Never',
    ];


    List<String> selectedOptionsDesires = [];

    List<String> selectedOptionsParties = [];
    List<String> selectedOptionsHobbies = [];
    List<String> selectedOptionsLookingFor = [];
    final controllerRegister = Get.put(ControllerRegistration());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(text: "Filter", style: AppFonts.titleLogin),
              Obx(() {
                return DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Select Country"),
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  value: country.value,
                  onChanged: (newCountry) {
                    country.value = newCountry;
                  },
                  items: locationData!.countryCityData.keys.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                );
              }).marginOnly(bottom: 10.h, left: 10.w, right: 10.w, top: 10.h,),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
              MyInputField(
                keyboardType: TextInputType.number,
                controller: ageController,
                hint: "Age",
                // suffix: Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ).marginOnly(right: 10.w,),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
              MyInputField(
                readOnly: true,
                controller: controllerRegister.eyeColorController,
                hint: "Eye Color",
                suffix: PopupMenuButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
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
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
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
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
              MyInputField(
                // readOnly: true,
                controller: genderController,
                hint: "Gender",
                // suffix: PopupMenuButton<String>(
                //   icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                //   onSelected: (String value) {
                //     controllerRegister.ethnicityController.text = value;
                //   },
                //   itemBuilder: (BuildContext context) {
                //     return controllerRegister.ethnicities
                //         .map<PopupMenuItem<String>>((String value) {
                //       return PopupMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList();
                //   },
                // ),
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
              MyInputField(
                  controller: controllerRegister.educationController,

                  hint: "Education level",
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
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return MyInputField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: controllerRegister.languagesList.value.join(', '),
                    ),
                    hint: "Language spoken",
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
              },),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.buttonColor,
                  width: Get.width),
              GradientText(text:
              "How often do you drink?", style: AppFonts.subscriptionTitle),
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
              GradientDivider(thickness: .3,
                  gradient: AppColors.buttonColor,
                  width: Get.width).marginSymmetric(vertical: 12.h),
              GradientText(text:
              "How often do you smoke?", style: AppFonts.subscriptionTitle),
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
              GradientDivider(thickness: .3,
                  gradient: AppColors.buttonColor,
                  width: Get.width).marginSymmetric(vertical: 12.h),
              GradientText(text:
              "What is your Body Type?", style: AppFonts.subscriptionTitle),
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
              GradientDivider(thickness: .3,
                  gradient: AppColors.buttonColor,
                  width: Get.width).marginSymmetric(vertical: 12.h),
              GradientText(
                  text: "Safety Practices", style: AppFonts.subscriptionTitle),
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

              GradientText(
                gradient: AppColors.buttonColor,
                text:
                "Hobbies",
                style: AppFonts.subscriptionTitle,
              ).paddingSymmetric(
                vertical: 6.h,
              ),
              CustomChipsChoice<String>(
                options: optionsHobbies,
                selectedOptions: selectedOptionsHobbies,
                onChanged: (List<String> selectedItems) {
                  controllerRegister.selectedHobbies = selectedItems;
                },
              ),
              GradientDivider(
                thickness: .3,
                gradient: AppColors.buttonColor,
                width: Get.width,
              ).marginSymmetric(
                vertical: 12.h,
              ),
              GradientText(
                gradient: AppColors.buttonColor,
                text:
                "Desires",
                style: AppFonts.subscriptionTitle,
              ).paddingSymmetric(
                vertical: 6.h,
              ),
              CustomChipsChoice<String>(
                options: optionDesires,
                selectedOptions: selectedOptionsDesires,
                onChanged: (selectedItems) {
                  controllerRegister.selectedDesires = selectedItems;
                },
              ),
              GradientDivider(
                thickness: .3,
                gradient: AppColors.buttonColor,
                width: Get.width,
              ).marginSymmetric(
                vertical: 12.h,
              ),
              GradientText(
                gradient: AppColors.buttonColor,
                text:
                "Parties",
                style: AppFonts.subscriptionTitle,
              ).paddingSymmetric(
                vertical: 6.h,
              ),
              CustomChipsChoice<String>(
                options: optionParties,
                selectedOptions: selectedOptionsParties,
                onChanged: (selectedItems) {
                  controllerRegister.selectedParties = selectedItems;
                },
              ),
              GradientDivider(
                thickness: .3,
                gradient: AppColors.buttonColor,
                width: Get.width,
              ).paddingSymmetric(
                vertical: 12.h,
              ),
              GradientText(
                gradient: AppColors.buttonColor,
                text:
                "What are you looking for?",
                style: AppFonts.subscriptionTitle,
              ).paddingSymmetric(
                vertical: 6.h,
              ),
              CustomChipsChoice<String>(
                options: optionLookingFor,
                selectedOptions: selectedOptionsLookingFor,
                onChanged: (List<String> selectedItems) {
                  controllerRegister.selectedLookingFor = selectedItems;
                },
              ),
              GradientDivider(
                thickness: .3,
                gradient: AppColors.buttonColor,
                width: Get.width,
              ).marginSymmetric(
                vertical: 12.h,
              ),
              CustomSelectbaleButton(
                onTap: () {


                  Get.find<ControllerGetUserAllData>().getUserDataAdvanced(
                    lookingFor: controllerRegister.selectedLookingFor,
                    desires: controllerRegister.selectedDesires,
                    ethnicity: controllerRegister.ethnicityController.text,
                    eyeColor: controllerRegister.eyeColorController.text,
                    parties: controllerRegister.selectedParties,
                    country: country.value,
                    age: int.tryParse(ageController.text) ?? 0,
                    bodyType: controllerRegister.selectBodyType.value,
                    languages: controllerRegister.languagesList,
                    education: controllerRegister.educationController.text,
                    // height: controllerRegister.heightController.text,
                    // weight: controllerRegister.weightController.text,
                    smoking: controllerRegister.howOftenSmoke.value,
                    hobbies: controllerRegister.selectedHobbies,
                    drinking: controllerRegister.howOftenDrink.value,
                    sexuality: genderController.text
                    // distancePreference: controllerRegister.distanceController.text,
                    // ageMin: controllerRegister.ageMinController.text,
                    // ageMax: controllerRegister.ageMaxController.text,
                    // location: controllerRegister.locationController.text,
                    // attributes: controllerRegister.selectedAttributes,

                    // sexuality: controllerRegis.text,
                  );

                },
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.buttonColor,
                titleButton: "Apply Filter",
                width: Get.width,
                height: 54.h,
                strokeWidth: 2
                ,).marginSymmetric(vertical: 15.h, horizontal: 15.w,)
            ],
          ).marginSymmetric(horizontal: 15.w, vertical: 15.h),
        ),
      ),
    );
  }
}
