import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_email_page4.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_photos_page5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../models/user.dart';
import '../../../widgets/custom_chip_choice.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenAmenitiesInfdividual extends StatefulWidget {
 String step;
  @override
  State<ScreenAmenitiesInfdividual> createState() =>
      _ScreenAmenitiesInfdividualState();

 ScreenAmenitiesInfdividual({
    required this.step,
  });
}

class _ScreenAmenitiesInfdividualState
    extends State<ScreenAmenitiesInfdividual> {
  int isCheck = -1;
  ControllerRegistration controllerRegister = Get.put(ControllerRegistration());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              text: "Choose Your\nAmenities",
              style: AppFonts.titleLogin, gradient: AppColors.buttonColor,
            ),
            Text(
              "Customize Your Venue's Offerings",
              style: AppFonts.subtitle,
            ),
            CustomChipsChoice<String>(
              options: controllerRegister.freeServices,
              selectedOptions: controllerRegister.selectedServices,
              onChanged: (selectedItems) {
                controllerRegister.selectedServices = selectedItems;
              },
            ).marginSymmetric(
              vertical: 25.h,
            ),

            Spacer(),
            Obx(() {

              return CustomSelectbaleButton(
                isLoading: controllerRegister.isLoading.value,
                onTap: () async {
                  if (controllerRegister.selectedServices.isNotEmpty) {
                    if (controllerRegister.userType.value=="individual_event_organizer") {
                      Get.to(ScreenChooseEmail(step: "5 of 5"));
                    }
                    else{
                      Get.to(ScreenAddPhotos(step: "8/9",));
                    }
                  } else {
                    FirebaseUtils.showError("Please Select Amenities");
                  }
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
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }
}
