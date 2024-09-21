import 'dart:developer';

import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/personal_information_screens_couple/screen_about_details_page7.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import '../../../constants/colors.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/authentication_controllers/controller_registration.dart';
import '../../../widgets/custom_selectable_button.dart';

class ScreenChooseHeight extends StatefulWidget {
  String step;
  User user;
  String? id,link;

  @override
  State<ScreenChooseHeight> createState() => _ScreenChooseHeightState();

  ScreenChooseHeight({
    required this.step,
    required this.user,
    this.id,
    this.link,
  });
}

class _ScreenChooseHeightState extends State<ScreenChooseHeight> {
  final controllerRegister = Get.put(ControllerRegistration());
  final List<double> values = List.generate(
      200, (index) => double.parse(((index + 1) * 0.1).toStringAsFixed(1)));


  final List<String> heights = [
    '0\' 0"',
    '0\' 1"',
    '0\' 2"',
    '0\' 3"',
    '0\' 4"',
    '0\' 5"',
    '0\' 6"',
    '0\' 7"',
    '0\' 8"',
    '0\' 9"',
    '0\' 10"',
    '0\' 11"',
    '1\' 0"',
    '1\' 1"',
    '1\' 2"',
    '1\' 3"',
    '1\' 4"',
    '1\' 5"',
    '1\' 6"',
    '1\' 7"',
    '1\' 8"',
    '1\' 9"',
    '1\' 10"',
    '1\' 11"',
    '2\' 0"',
    '2\' 1"',
    '2\' 2"',
    '2\' 3"',
    '2\' 4"',
    '2\' 5"',
    '2\' 6"',
    '2\' 7"',
    '2\' 8"',
    '2\' 9"',
    '2\' 10"',
    '2\' 11"',
    '3\' 0"',
    '3\' 1"',
    '3\' 2"',
    '3\' 3"',
    '3\' 4"',
    '3\' 5"',
    '3\' 6"',
    '3\' 7"',
    '3\' 8"',
    '3\' 9"',
    '3\' 10"',
    '3\' 11"',
    '4\' 0"',
    '4\' 1"',
    '4\' 2"',
    '4\' 3"',
    '4\' 4"',
    '4\' 5"',
    '4\' 6"',
    '4\' 7"',
    '4\' 8"',
    '4\' 9"',
    '4\' 10"',
    '4\' 11"',
    '5\' 0"',
    '5\' 1"',
    '5\' 2"',
    '5\' 3"',
    '5\' 4"',
    '5\' 5"',
    '5\' 6"',
    '5\' 7"',
    '5\' 8"',
    '5\' 9"',
    '5\' 10"',
    '5\' 11"',
    '6\' 0"',
    '6\' 1"',
    '6\' 2"',
    '6\' 3"',
    '6\' 4"',
    '6\' 5"',
    '6\' 6"',
    '6\' 7"',
    '6\' 8"',
    '6\' 9"',
    '6\' 10"',
    '6\' 11"',
    '7\' 0"',
    '7\' 1"',
    '7\' 2"',
    '7\' 3"',
    '7\' 4"',
    '7\' 5"',
    '7\' 6"',
    '7\' 7"',
    '7\' 8"',
    '7\' 9"',
    '7\' 10"',
    '7\' 11"',
    '8\' 0"',
    '8\' 1"',
    '8\' 2"',
    '8\' 3"',
    '8\' 4"',
    '8\' 5"',
    '8\' 6"',
    '8\' 7"',
    '8\' 8"',
    '8\' 9"',
    '8\' 10"',
    '8\' 11"',
    '9\' 0"',
    '9\' 1"',
    '9\' 2"',
    '9\' 3"',
    '9\' 4"',
    '9\' 5"',
    '9\' 6"',
    '9\' 7"',
    '9\' 8"',
    '9\' 9"',
    '9\' 10"',
    '9\' 11"',


  ];
  int selectedHeightIndex = 17;

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
          title: Text(widget.step, style: AppFonts.personalinfoAppBar),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(text:"How tall you are", style: AppFonts.titleLogin),
            Text(
              "Climb to Lust: Connecting Hearts Beyond\nHeights.",
              style: AppFonts.subtitle,
            ),
            Container(
              height: 250,
              child: Stack(
                children: [
                  CupertinoPicker(
                    backgroundColor: Colors.black,
                    itemExtent: 70.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedHeightIndex),
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedHeightIndex = index;
                      });
                      controllerRegister.height.value =
                      heights[selectedHeightIndex];
                    },
                    children: heights.map((String height) {
                      return Center(
                        child: Text(
                          height,
                          style: TextStyle(color: Colors.white,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    top: 80.h,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 80.h,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading: controllerRegister.isLoading.value,
                onTap: () async {
                  if (controllerRegister.height.value.isNotEmpty) {
                    await controllerRegister.updateHeight(widget.user,widget.id??'',widget.link?? "");
                  }
                  else {
                    FirebaseUtils.showError( "Please select your height.");}
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
          vertical: 10.sp,
        ),
      ),
    );
  }
}
