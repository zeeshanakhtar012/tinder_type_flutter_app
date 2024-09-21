import 'dart:developer';

import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_email_page4.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_height_page6.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/custom_image_picker_container.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenAddPhotos extends StatefulWidget {
  String step;
  User? user;

  @override
  State<ScreenAddPhotos> createState() => _ScreenAddPhotosState();

  ScreenAddPhotos({
    required this.step,
    this.user,
  });
}

class _ScreenAddPhotosState extends State<ScreenAddPhotos> {
  List<String> imagePaths = [];
  final controllerRegister = Get.put(ControllerRegistration());

  String selectedPrivacy = '0';

  void _onImagePicked(String imagePath) {
    setState(() {
      imagePaths.add(imagePath);
      controllerRegister.recentImages.value = imagePaths;
    });
  }

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              text: "Add your recent photos",
              style: AppFonts.subscriptionBlaxityGold,
              gradient: AppColors.buttonColor,
            ).marginOnly(
              top: 15.h,
            ),
            Text(
              "Frame Your Lust Story",
              style: AppFonts.subtitle,
            ).marginOnly(
              bottom: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImagePickerContainer(onImagePicked: _onImagePicked),
                CustomImagePickerContainer(onImagePicked: _onImagePicked),
                CustomImagePickerContainer(onImagePicked: _onImagePicked),
              ],
            ).marginSymmetric(
              vertical: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImagePickerContainer(
                  onImagePicked: _onImagePicked,
                ),
                CustomImagePickerContainer(
                  onImagePicked: _onImagePicked,
                ),
                CustomImagePickerContainer(
                  onImagePicked: _onImagePicked,
                ),
              ],
            ).marginSymmetric(
              vertical: 10.h,
            ),
            GradientText(
              text: "Set Your Profile Privacy",
              style: AppFonts.subtitleImagePickerButtonColor.copyWith(
                fontWeight: FontWeight.bold
              ),
              gradient: AppColors.buttonColor,
            ).marginOnly(
                top: 10.h,
                bottom: 6.h),
            Obx(
              () => CustomCheckbox(
                isSelected: controllerRegister.privacy == '0',
                onChanged: (isSelected) {
                  if (isSelected) {
                    controllerRegister.privacy.value = '0';
                  } else {
                    controllerRegister.privacy.value = "";
                  }
                },
                titleText: "Public",
              ),
            ),
            Obx(() => CustomCheckbox(
                  isSelected: controllerRegister.privacy.value == '1',
                  onChanged: (isSelected) {
                    if (isSelected) {
                      controllerRegister.privacy.value = '1';
                    } else {
                      controllerRegister.privacy.value = "";
                    }
                    print(selectedPrivacy);
                  },
                  titleText: "Private",
                )).marginSymmetric(
              vertical: 6.h,
            ),
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFA7713F),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    "${imagePaths.length}/6",
                  )),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                    "Begin your journey by uploading up to 2 pictures\nof yourselves to kickstart your experience."),
              ],
            ).marginSymmetric(vertical: 15.h),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading: controllerRegister.isLoading.value,
                onTap: () async {
                  if (controllerRegister.recentImages.isNotEmpty) {
                    String userType =  controllerRegister.userType.value;
                    if (userType == "club_event_organizer") {
                      Get.to(ScreenChooseEmail(step: "8 of 9"));
                    } else {
                      await controllerRegister.updatePhotos(widget.user!);
                    }
                  } else {
                    FirebaseUtils.showError("Please add photos");
                  }
                  // Get.to(ScreenChooseHeight(),
                  //  );
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Continue",
              );
            }),
          ],
        ).marginSymmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
      ),
    );
  }
}
