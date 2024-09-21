import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_email_page4.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_email_otp_page10.dart';
import 'package:flutter/cupertino.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenPassion extends StatefulWidget {
 String step;
 User? user;
  @override
  State<ScreenPassion> createState() => _ScreenPassionState();

 ScreenPassion({
    required this.step,
    this.user,
  });
}

class _ScreenPassionState extends State<ScreenPassion> {
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

  List<String> selectedOptionsDesires = [];

  List<String> selectedOptionsParties = [];
  List<String> selectedOptionsHobbies = [];
  List<String> selectedOptionsLookingFor = [];
  final controllerRegister = Get.put(ControllerRegistration());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            widget.step,
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                text:
              "Passions Unveiled",
                style: AppFonts.titleLogin,
                gradient: AppColors.buttonColor,
              ),
              Text(
                "Exploring Hobbies, Desires and Party\npreferences",
                style: AppFonts.subtitle,
              ),
              GradientText(
                gradient: AppColors.buttonColor,
                text:
                "Hobbies",
                style: AppFonts.subscriptionTitle,
              ).paddingOnly(
                top: 20.h,
              ),
              CustomChipsChoice<String>(
                options: optionsHobbies,
                selectedOptions: selectedOptionsHobbies,
                onChanged: (List<String> selectedItems) {
                  controllerRegister.selectedHobbies = selectedItems;
                },
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
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
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
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
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
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
                    if (controllerRegister.selectedHobbies.isNotEmpty &&
                        controllerRegister.selectedLookingFor.isNotEmpty &&
                        controllerRegister.selectedParties.isNotEmpty &&
                        controllerRegister.selectedDesires.isNotEmpty) {
                      log(widget.user!.toString());
                      await controllerRegister.updatePassion(widget.user!);
                    } else {
                      FirebaseUtils.showError("Please select all options");
                       }
                  },
                  borderRadius: BorderRadius.circular(20),
                  width: Get.width,
                  height: 54.h,
                  strokeWidth: 1,
                  gradient: AppColors.buttonColor,
                  titleButton: "Continue",
                );
              }).marginSymmetric(
                vertical: 12.h,
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
        ),
      ),
    );
  }
}
