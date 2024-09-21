import 'package:blaxity/controllers/controller_get_couple.dart';
import 'package:blaxity/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';

class ScreenViewCoupleConnections extends StatelessWidget {
  List<NetWork> connections;
  String name;
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
            "Connections",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GradientText(text:
            "${name} Connections",
              style: AppFonts.titleLogin,
            ),

            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: connections.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6,crossAxisSpacing: 10,mainAxisSpacing: 10),
                padding: EdgeInsets.all(10.h), itemBuilder: (BuildContext context, int index) {
                  NetWork _user=connections[index];
                return Container(
                  height: 39.33.h,
                  width: 39.33.w,
                  margin: EdgeInsets.only(right: 3.w),
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    // gradient: AppColors.buttonColor,
                    border: Border.all(
                      width: 2.w,
                      color: Color(0xFFA7713F),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return AppColors.buttonColor
                              .createShader(bounds);
                        },
                        child: (_user.user_type=="couple")?Icon(
                          Icons.group,
                          size: 15.h,
                        ):Icon(
                          Icons.person,
                          size: 15.h,
                        ),
                      ),
                      Text(
                        " ${_user.f_name}",
                        style: TextStyle(
                          fontSize: 6.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },

              ),
            )


          ],
        ).marginSymmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
      ),
    );
  }



  ScreenViewCoupleConnections({
    required this.connections,
    required this.name,
  });
}
