import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/controllers/user_controller.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_selectable_button.dart';
import '../layouts/item_invite_user_anonymous.dart';
import '../layouts/item_user_invite_anon_number.dart';

class ScreenAddUserAnonymously extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxString countryCode = ''.obs;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back(
                  result: true,
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Invite\nAnonymously",
                  style: AppFonts.titleLogin,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Invite crushes anonymously, they'll get an\nemail/message without knowing it's from you.\nWill they join?",
                  style: AppFonts.subtitle,
                ),
              ).marginSymmetric(
                vertical: 5.sp,
              ),
              MyInputField(
                hint: "Email",
                controller: emailController,
              ),
              GradientDivider(
                  thickness: .3,
                  gradient: AppColors.buttonColor,
                  width: MediaQuery
                      .sizeOf(context)
                      .width),
              Obx(() {
                return ItemInviteUserAnonymous(
                  isLoading: userController.isEmailLoading.value,
                  text: 'Send',
                  onTap: () async {
                    if (emailController.text.isNotEmpty) {
                      userController.isEmailLoading.value=true;
                      var link = await Get.find<ControllerRegistration>()
                          .createDynamicLink();
                      await userController.sendWhatsAppMessage(
                          null, link, emailController.text);
                      userController.isEmailLoading.value=false;
                    }
                  },
                );
              }).paddingOnly(
                top: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 0.75.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonColor,
                    ),
                  ),
                  Text(
                    "Or",
                    style: TextStyle(
                      color: Color(0xff5B5B5B),
                      fontSize: 24.sp,
                    ),
                  ),
                  Container(
                    height: 0.75.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonColor,
                    ),
                  ),
                ],
              ).marginOnly(
                top: 30.sp,
              ),
              MyInputField(
                // readOnly: true,
                hint: "70000000",
                controller: phoneController,
                prefix: IntrinsicHeight(
                  child: CountryCodePicker(
                    boxDecoration: BoxDecoration(
                      gradient: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                    onChanged: (value) {
                      countryCode.value = value.dialCode.toString();
                    },
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Arial",
                        color: Colors.white),
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'LB',
                    favorite: ['+961', 'LB'],

                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: true,

                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                ),
              ).marginOnly(
                top: 30.sp,
              ),
              GradientDivider(
                  thickness: .3,
                  gradient: AppColors.buttonColor,
                  width: MediaQuery
                      .sizeOf(context)
                      .width),
              Obx(() {
                return ItemInviteNumberAnonymous(
                  isLoading: userController.isNumberLoading.value,
                  text: 'Send',
                  onTap: () async {
                    String phone = phoneController.text;
                    if (phone.isEmpty) {
                      FirebaseUtils.showError("Please enter your phone number");
                    } else {
                      userController.isNumberLoading.value=true;
                      var link = await Get.find<ControllerRegistration>()
                          .createDynamicLink();
                      if (phone.isNotEmpty) {
                        userController.sendWhatsAppMessage(
                            countryCode.value + phoneController.text,
                            link,
                            null);

                        userController.isNumberLoading.value=false;
                      }
                    }
                  },
                );
              }).paddingOnly(
                top: 20.h,
              ),
            ],
          ).marginSymmetric(
            horizontal: 25.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }
}
