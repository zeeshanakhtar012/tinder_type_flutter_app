import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/fonts.dart';
import '../../widgets/gradient_widget.dart';

class ScreenViewDescription extends StatelessWidget {
 String description;
  ScreenViewDescription({required this.description});
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
            "Description",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GradientText(text:
            "Profile Description",
              style: AppFonts.titleLogin,
            ),

            SizedBox(
              height: 30.h,
            ),
            GradientWidget(
              child: TextFormField(
                maxLength: 180,
                readOnly: true,
                maxLines: 14,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
                controller: TextEditingController(text: description),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    // counter: Text(""),
                    hintText: "No Description",
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400)


                ),
              ),
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
