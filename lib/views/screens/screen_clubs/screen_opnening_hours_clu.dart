import 'dart:developer';

import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_describe_page8.dart';
import 'package:blaxity/views/screens/screen_individual/screen_location_individual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../../widgets/my_input_feild.dart';

class ScreenOpeningHours extends StatefulWidget {
  User ? user;

  @override
  State<ScreenOpeningHours> createState() => _ScreenOpeningHoursState();

  ScreenOpeningHours({
    this.user,
  });
}

class _ScreenOpeningHoursState extends State<ScreenOpeningHours> {
  // RxString dateOfBirth = ''.obs;
  ControllerRegistration controllerRegistration = Get.put(
      ControllerRegistration());
Club ? club;
  @override
  Widget build(BuildContext context) {
    if (widget.user!=null) {
      club = widget.user!.clubs!.first;
    }
    if (club != null) {
      controllerRegistration.openingDay.value = club!.openingDate!;
      controllerRegistration.closingDay.value = club!.closingDay!;
      controllerRegistration.openingTime.value =club!.openingTime!;
      controllerRegistration.closingTime.value =club!.closingTime!;

    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text((widget.user != null) ? "" : "4/9", style: AppFonts.personalinfoAppBar,),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text: (widget.user != null) ? "Update Opening\n Hours and days" : "Share Your Opening\nHours",
                style: AppFonts.titleLogin,
                gradient: AppColors.buttonColor),
            Obx(() {
              return MyInputField(
                hint: "Select Opening and Closing Day",
                readOnly: true,
                controller: TextEditingController(
                  text: controllerRegistration.openingDay.value.isNotEmpty &&
                      controllerRegistration.closingDay.value.isNotEmpty
                      ? "${controllerRegistration.openingDay
                      .value}-${controllerRegistration.closingDay.value}"
                      : null,
                ),
                suffix: InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DayPickerDialog(
                        );
                      },
                    );
                    // final DateTime? picked = await showDatePicker(
                    //   builder: (context, child) {
                    //     return Theme(
                    //       data: Theme.of(context).copyWith(
                    //         colorScheme: ColorScheme.light(
                    //           primary: Color(0xFFA7713F), // header background color
                    //           onPrimary: Colors.black, // header text color
                    //           onSurface: Colors.black, // body text color
                    //         ),
                    //         textButtonTheme: TextButtonThemeData(
                    //           style: TextButton.styleFrom(
                    //             foregroundColor: Colors.black, // button text color
                    //           ),
                    //         ),
                    //       ),
                    //       child: child!,
                    //     );
                    //   },
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(1900),
                    //   lastDate: DateTime(2101),
                    // );
                    // if (picked != null && picked != DateTime.now()) {
                    //   controllerRegistration.openingDate.text = "${picked.toLocal()}".split(' ')[0];
                    //
                    // }
                  },
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: Icon(
                      Icons.calendar_month,
                      size: 24,
                    ),
                  ),
                ),
              );
            }),
            GradientDivider(gradient: AppColors.buttonColor,
              width: Get.width,
              thickness: .3,),
            Obx(() =>
                MyInputField(
                  hint: "Select Opening and Closing Time",
                  readOnly: true,
                  controller: TextEditingController(
                      text: "${ controllerRegistration.openingTime
                          .value}-${ controllerRegistration.closingTime
                          .value}"),
                  suffix: InkWell(
                    onTap: () async {
                      // Select Opening Time
                      final TimeOfDay? openingTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xFFA7713F),
                                onPrimary: Colors.black,
                                onSurface: Colors.black,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (openingTime != null) {
                        // Select Closing Time after selecting Opening Time
                        final TimeOfDay? closingTime = await showTimePicker(
                          context: context,
                          initialTime: openingTime,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Color(0xFFA7713F),
                                  onPrimary: Colors.black,
                                  onSurface: Colors.black,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (closingTime != null) {
                          // Convert to 24-hour format
                          String formatTimeOfDay(TimeOfDay tod) {
                            final now = DateTime.now();
                            final dt = DateTime(
                                now.year, now.month, now.day, tod.hour,
                                tod.minute);
                            final format = DateFormat(
                                'HH:mm:ss'); // Using intl package
                            return format.format(dt);
                          }
                          // Update the controller with the 24-hour format time
                          controllerRegistration.openingTime.value =
                              formatTimeOfDay(openingTime);
                          controllerRegistration.closingTime.value =
                              formatTimeOfDay(closingTime);
                        }
                      }
                    },
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: Icon(
                        Icons.watch_later_outlined,
                        size: 24,
                      ),
                    ),
                  ),
                )),

            GradientDivider(gradient: AppColors.buttonColor,
              width: Get.width,
              thickness: .3,),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading:controllerRegistration.isLoading.value,
                onTap: () {
                  if (controllerRegistration.openingTime.isNotEmpty &&
                      controllerRegistration.openingTime.isNotEmpty) {
                    log("Opening Time: ${controllerRegistration.openingTime
                        .value}");
                    log("Closing Time: ${controllerRegistration.closingTime
                        .value}");
                    log("Opening Day: ${controllerRegistration.openingDay
                        .value}");
                    log("Closing Day: ${controllerRegistration.closingDay
                        .value}");
                    if (widget.user == null) {
                      Get.to(ScreenDescribe(step: "5 of 9"));
                    } else {
                      controllerRegistration.updateClub(club: club!, f_name: widget.user!.fName?? "Test", descrption: widget.user!.reference!.description?? "Test Decription",
                          openingDay: controllerRegistration.openingDay.value,
                          openingTime: controllerRegistration.openingTime.value,
                          closingTime: controllerRegistration.closingTime.value,
                           closingDay: controllerRegistration.closingDay.value, phone: widget.user!.phone?? "",
                      );
                    }
                  }
                  else {
                    Get.snackbar("Error", "Please select date and time",
                        backgroundColor: Colors.red, colorText: Colors.white);
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


class DayPickerDialog extends StatelessWidget {
  final ControllerRegistration controllerRegistration = Get.find();

  final List<String> daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Days'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w
            ),
            decoration: BoxDecoration(
                color: Color(0xFF424242),
                borderRadius: BorderRadius.circular(12.sp)
            ),
            child: Obx(() =>
                DropdownButton<String>(
                  hint: Text("Opening Day"),
                  isExpanded: true,
                  underline: SizedBox(),

                  value: controllerRegistration.openingDay.value.isEmpty
                      ? null
                      : controllerRegistration.openingDay.value,
                  onChanged: (String? newValue) {
                    controllerRegistration.openingDay.value = newValue!;
                  },
                  items: daysOfWeek.map<DropdownMenuItem<String>>((
                      String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ).marginSymmetric(vertical: 10.h),
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w
            ),
            decoration: BoxDecoration(
                color: Color(0xFF424242),
                borderRadius: BorderRadius.circular(12.sp)
            ),
            child: Obx(() =>
                DropdownButton<String>(
                  hint: Text("Closing Day"),
                  isExpanded: true,
                  underline: SizedBox(),


                  value: controllerRegistration.closingDay.value.isEmpty
                      ? null
                      : controllerRegistration.closingDay.value,
                  onChanged: (String? newValue) {
                    controllerRegistration.closingDay.value = newValue!;
                  },
                  items: daysOfWeek.map<DropdownMenuItem<String>>((
                      String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          )
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
