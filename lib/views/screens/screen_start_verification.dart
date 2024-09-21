import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/user_controller.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:blaxity/widgets/custom_splash_button.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_picker_container.dart';

class ScreenVerification extends StatefulWidget {
  const ScreenVerification({super.key});

  @override
  _ScreenVerificationState createState() => _ScreenVerificationState();
}

class _ScreenVerificationState extends State<ScreenVerification> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  UserController userController = Get.put(UserController());

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              // ListTile(
              //   leading: Icon(Icons.photo_library),
              //   title: Text('Gallery'),
              //   onTap: () async {
              //     Navigator.of(context).pop();
              //     final pickedFile = await _picker.pickImage(
              //       source: ImageSource.gallery,
              //       maxWidth: 800,
              //       maxHeight: 800,
              //     );
              //     if (pickedFile != null) {
              //       setState(() {
              //         _imageFile = pickedFile;
              //       });
              //     }
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 800,
                    maxHeight: 800,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = pickedFile;
                    });
                  }
                },
              ).marginOnly(bottom: 50.h,top: 40.h),
            ],
          ),
        );
      },
    );
  }

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile Verification",
                style: AppFonts.titleLogin,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Verify your profile by providing a brief\ndescription and uploading a clear image of\nyourself.",
                style: TextStyle(fontSize: 14.sp, color: Color(0xFFCDCDCD)),
              ),
            ),
            TextField(
              controller: descriptionController,
              style: TextStyle(fontSize: 16.sp, color: Color(0xFFCDCDCD)),
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(color: Color(0xFFCDCDCD)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                          0xFFCDCDCD)), // Color of the underline when the TextField is enabled
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(
                          0xFFCDCDCD)), // Color of the underline when the TextField is focused
                ),
                border:
                    UnderlineInputBorder(), // Ensures there's an underline even if no other decoration is provided
              ),
            ).marginOnly(
              top: 5.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upload Image",
                  style: TextStyle(
                    color: Color(0xffCDCDCD),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pickImage(context);
                  },
                  icon: Icon(
                    CupertinoIcons.plus_circle,
                    color: Color(0xFFCDCDCD),
                  ),
                ),
              ],
            ).marginOnly(
              top: 5.sp,
            ),
            if (_imageFile != null)
              Padding(
                padding: EdgeInsets.only(top: 10.sp),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: Image.file(
                    File(_imageFile!.path),
                    width: 100.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Row(
              children: [
                Icon(
                  color: Color(0xffCDCDCD),
                  size: 5.h,
                  Icons.fiber_manual_record,
                ),
                Text(
                  "Please ensure that your face is clearly visible in the\nuploaded image.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                  ),
                ).marginOnly(
                  left: 6.sp,
                ),
              ],
            ).marginOnly(
              top: 5.sp,
            ),
            Row(
              children: [
                Icon(
                  color: Color(0xffCDCDCD),
                  size: 5.h,
                  Icons.fiber_manual_record,
                ),
                Text(
                  "Your uploaded image is not stored in our database\nand will be destroyed upon verification.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                  ),
                ).marginOnly(
                  left: 6.sp,
                ),
              ],
            ).marginOnly(
              top: 10.sp,
            ),
            SizedBox(
              height: 50.h,
            ),
            GradientText(
                gradient: AppColors.buttonColor,
                textAlign: TextAlign.center,
                text:
                    'Your uploaded image is not stored in our database\nand will be destroyed upon verification.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
            Spacer(),
            CustomSplashButton(
              borderRadius: BorderRadius.circular(20),
              isSelected: true,
              titleButton: "Submit for Verification",
              gradient: AppColors.buttonColor,
              onTap: () async {
                String description = descriptionController.text;
                await userController.uploadSelfie(
                    File(_imageFile!.path), description);
                // Submit functionality
              },
              width: Get.width,
              height: 52.h,
              strokeWidth: 3,
            ).marginSymmetric(
              vertical: 3.sp,
            ),
          ],
        ).marginSymmetric(
          horizontal: 25.h,
          vertical: 15.h,
        ),
      ),
    );
  }
}
