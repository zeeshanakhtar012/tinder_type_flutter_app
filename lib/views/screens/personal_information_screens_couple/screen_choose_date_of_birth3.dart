import 'dart:developer';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_choose_email_page4.dart';
import 'package:blaxity/widgets/pin_put.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';

class ScreenChooseDate extends StatelessWidget {
  final String step;
  final User? user;
  final String? id;
  final String? link;
  final List<TextEditingController> _controllers = List.generate(8, (_) => TextEditingController());
  final controllerRegister = Get.put(ControllerRegistration());
  final TextEditingController _dateController = TextEditingController();
  ScreenChooseDate({
    required this.step,
    this.user,
    this.id,
    this.link,
  });

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
          title: Text(step, style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text: "What is your date of\nbirth?", style: AppFonts.titleLogin,),
            Text(
              "You must be 18+ to explore Blaxity. Your age\nwill appear on your profile. Your date of birth\nwill remain private",
              style: AppFonts.subtitle,),


            // PinCodeTextField(appContext: context, length: 8, onChanged: (value) {  },
            // hintCharacter: "1",
            //
            // ),
            // MyInputField(
            //   readOnly: true,
            //   controller: _dateController,
            //   suffix: IconButton(
            //     onPressed: () async {
            //       DateTime? selectedDate = await showDatePicker(
            //         context: context,
            //         initialDate: DateTime.now(),
            //         firstDate: DateTime(2000),
            //         lastDate: DateTime(2100),
            //       );
            //
            //       if (selectedDate != null) {
            //         String formattedDate =
            //             "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
            //       }
            //     },
            //     icon: Icon(Icons.calendar_month, color: Colors.grey),
            //   ),
            //   hint: "Choose Date",
            // ),
            //     GradientDivider(
            //       thickness: 0.3,
            //       gradient: AppColors.buttonColor,
            //       width: Get.width,
            //     ).marginSymmetric(
            //       horizontal: 15.w,
            //     ),
            Center(
              child: CustomDateInputField(
                backgroundColor: Colors.black,
                hints: ['D', 'D', 'M', 'M', 'Y', 'Y', 'Y', 'Y'],
                controllers: _controllers,
                boxWidth: 30.0.w,
                boxHeight: 20.0.h,
                textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                inputDecoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ).marginSymmetric(
              vertical: 15.sp,
            ),
            Spacer(),
            CustomSelectbaleButton(
              onTap: () {
                // Extract date values from the controllers
                String day = _controllers.sublist(0, 2).map((c) => c.text).join();
                String month = _controllers.sublist(2, 4).map((c) => c.text).join();
                String year = _controllers.sublist(4).map((c) => c.text).join();

                // Format the date string
                String dateOfBirth = '$day/$month/$year';

                try {
                  DateTime parsedDate = DateFormat("dd/MM/yyyy").parseStrict(dateOfBirth);

                  // Calculate the age
                  controllerRegister.age.value = _calculateAge(parsedDate);

                  // Validate age
                  if (controllerRegister.age.value >= 18) {

                    controllerRegister.birthDate.value = parsedDate;
                    log("Age${controllerRegister.age.value}");
                    log("Dod${controllerRegister.birthDate.value}");
                    log("PartnerName${controllerRegister.firstPartnerName.text}");
                    log("PartnerAge${controllerRegister.secondPartnerName.text}");


                    Get.to(ScreenChooseEmail(step: '4 of 11', link: link, id: id));
                  } else {
                    FirebaseUtils.showError( "You must be at least 18 years old.");
                  }
                } catch (e) {
                  FirebaseUtils.showError( "Please enter a valid date.");
                }
              },
              borderRadius: BorderRadius.circular(20),
              width: Get.width,
              height: 52.h,
              strokeWidth: 1,
              gradient: AppColors.buttonColor,
              titleButton: "Continue",
            ).marginOnly(
              bottom: 10.sp,
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 10.sp,
        ),
      ),
    );
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

}
