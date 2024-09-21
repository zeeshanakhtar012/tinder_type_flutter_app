import 'dart:developer';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/controllers/conttoller_get_partner.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_country_page2.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_date_of_birth3.dart';
import 'package:blaxity/widgets/custom_toggle_switch.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/custom_switch_gender.dart';

class ScreenChoosePartner extends StatefulWidget {
 String? id;
 String? link;
  @override
  State<ScreenChoosePartner> createState() => _ScreenChoosePartnerState();

 ScreenChoosePartner({
    this.id,
    this.link,
  });
}

class _ScreenChoosePartnerState extends State<ScreenChoosePartner> {
  final ControllerRegistration controllerRegister = Get.put(ControllerRegistration());

ControllerGetPartner controllerGetPartner=Get.put((ControllerGetPartner()));
@override
  void initState() {
  controllerGetPartner.getPartner(widget.link??'').then((value){
    if(controllerGetPartner.user.value!=null) {
      controllerRegister.firstPartnerName.text=controllerGetPartner.user.value!.partner1Name!;
      controllerRegister.firstPartnerAge.text=(controllerGetPartner.user.value!.partner_1_age?? 0).toString();
      controllerRegister.secondPartnerName.text=controllerGetPartner.user.value!.partner2Name!;
      controllerRegister.secondPartnerAge.text=(controllerGetPartner.user.value!.partner_2_age?? 0).toString();
      controllerRegister.partnerOneGender.value=controllerGetPartner.user.value!.partner1Sex!;
      controllerRegister.partnerTwoGender.value=controllerGetPartner.user.value!.partner2Sex!;

    }
  });
  setState(() {

  });

  // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controllerGetPartner.user.value!=null) {
      controllerRegister.firstPartnerName.text=controllerGetPartner.user.value!.partner1Name!;
      controllerRegister.secondPartnerName.text=controllerGetPartner.user.value!.partner2Name!;
      controllerRegister.partnerOneGender.value=controllerGetPartner.user.value!.partner1Sex!;
      controllerRegister.partnerTwoGender.value=controllerGetPartner.user.value!.partner2Sex!;


    }
    log(widget.id??"No Id");
    log(widget.link??"No Link");
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
            "1/11",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text: "What shall we call\nyou?", style: AppFonts.titleLogin),
            MyInputField(
              controller: controllerRegister.firstPartnerName,
              hint: "Partner 1",
            ),

            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Obx(() {
                return CustomSwitchGenderButton(
                  onGenderChanged: (String gender) {
                    controllerRegister.updateMaleGender(gender);
                  },
                  selectedGender: controllerRegister.partnerOneGender.value,
                ).marginOnly(top: 5.sp);
              }),
            ),
            MyInputField(
              controller: controllerRegister.secondPartnerName,
              hint: "Partner 2",

            ),

            GradientDivider(
              thickness: 0.3,
              gradient: AppColors.buttonColor,
              width: Get.width,
            ).marginSymmetric(
              horizontal: 8.w,
            ),

            // Gender Switch for Female
            Align(
              alignment: Alignment.centerRight,
              child: Obx(() {
                return CustomSwitchGenderButton(
                  onGenderChanged: (String gender) {
                    controllerRegister.updateFemaleGender(gender);
                  },
                  selectedGender: controllerRegister.partnerTwoGender.value,
                ).marginOnly(top: 5.sp);
              }),
            ),
            // MyInputField(
            //   controller: controllerRegister.firstPartnerAge,
            //   hint: "Partner 1 Age",
            //   keyboardType: TextInputType.number,
            // ),GradientDivider(
            //   thickness: 0.3,
            //   gradient: AppColors.buttonColor,
            //   width: Get.width,
            // ),
            //
            // MyInputField(
            //   controller: controllerRegister.secondPartnerAge,
            //   hint: "Partner 2 Age",
            //   keyboardType: TextInputType.number,
            // ),GradientDivider(
            //   thickness: 0.3,
            //   gradient: AppColors.buttonColor,
            //   width: Get.width,
            // ),

            Spacer(),

            // Continue Button
            CustomSelectbaleButton(
              onTap: () {
                String firstName = controllerRegister.firstPartnerName.text.trim();
                String secondName = controllerRegister.secondPartnerName.text.trim();
                String firstAge = controllerRegister.firstPartnerAge.text.trim();
                String secondAge = controllerRegister.secondPartnerAge.text.trim();
                if (firstName.isNotEmpty && secondName.isNotEmpty) {
                 if (widget.id==null) {
                   Get.to(ScreenChooseCountry(step: '2 of 11',));
                 }
                 else{
                   controllerRegister.userType.value="couple";
                   Get.to(ScreenChooseDate(step: '2 of 11',id: widget.id,link: widget.link,));
                 }
                }  else{
                  FirebaseUtils.showError("Please fill all the fields");
                }
              },
              borderRadius: BorderRadius.circular(20),
              width: Get.width,
              height: 54.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Continue",
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 10.sp,
        ),
      ),
    );
  }
}
