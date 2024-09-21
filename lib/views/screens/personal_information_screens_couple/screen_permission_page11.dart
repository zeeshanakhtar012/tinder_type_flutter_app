import 'package:blaxity/controllers/authentication_controllers/controller_registration.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:blaxity/views/screens/screen_reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../constants/location_utils.dart';
import '../../../controllers/controller_get_couple_sphere.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../layouts/item_forgotPassword/item_forgot_password.dart';
import '../screen_exploring_together.dart';

class ScreenPermissions extends StatefulWidget {
  UserResponse user;
  String? id, link;

  @override
  State<ScreenPermissions> createState() => _ScreenPermissionsState();

  ScreenPermissions({
    required this.user,
    this.id,
    this.link,
  });
}

class _ScreenPermissionsState extends State<ScreenPermissions> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    ControllerRegistration controllerRegistration =
        Get.put(ControllerRegistration());
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
            "11/11",
            style: AppFonts.personalinfoAppBar,
          ),
        ),
        body: FutureBuilder<bool>(
            future: checkPermissionStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator.adaptive(
                  // backgroundColor: AppColors.,
                  strokeWidth: 3,
                ));
              }

              if (!(snapshot.data ?? false)) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Location Permission Required",
                      ),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text(
                            "Retry",
                          ))
                    ],
                  ),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    text: "Permissions",
                    style: AppFonts.subscriptionBlaxityGold,
                  ),
                  Text(
                    "Do we have your permission to access the following?",
                    style: AppFonts.subtitle
                        .copyWith(color: Colors.white, fontSize: 14.sp),
                  ).marginOnly(bottom: 10.h),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.chatColor),
                    child: ListTile(
                      // contentPadding: EdgeInsets.symmetric(vertical: 0),
                      title: Text(
                        "Notifications",
                        style: AppFonts.forgotScrItem.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp

                        ),
                      ),
                      leading: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return AppColors.buttonColor.createShader(bounds);
                        },
                        child: Icon(
                          Icons.notifications_none,
                          size: 24,
                        ),
                      ),
                      subtitle: Text(
                        "Know when someone likes you back or when\nsomeone sent a message.",
                        style: AppFonts.subtitle
                            .copyWith(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.chatColor),
                    child: ListTile(
                      // contentPadding: EdgeInsets.symmetric(vertical: 0),
                      title: Text(
                        "Location",
                        style: AppFonts.forgotScrItem.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp
                        ),
                      ),
                      leading: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return AppColors.buttonColor.createShader(bounds);
                        },
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 24,
                        ),
                      ),
                      subtitle: Text(
                        "We help you discover people based on your location",
                        style: AppFonts.subtitle
                            .copyWith(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomSelectbaleButton(
                    onTap: () async {
                      if (widget.id==null) {
                        Get.offAll(ScreenExploring(user: widget.user.user));
                        // await controllerRegistration
                        //     .updateLocation(widget.user);
                      }
                      else{
                        Get.offAll(ScreenWelcome());
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    width: Get.width,
                    height: 54.h,
                    strokeWidth: 1,
                    gradient: AppColors.buttonColor,
                    titleButton: "Continue",
                  )
                ],
              ).marginSymmetric(
                horizontal: 15.sp,
                vertical: 10.sp,
              );
            }),
      ),
    );
  }
}
