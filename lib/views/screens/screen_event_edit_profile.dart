import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/controllers/users_controllers/controller_delete_user.dart';
import 'package:blaxity/controllers/users_controllers/controller_get_user_all_data.dart';
import 'package:blaxity/models/user.dart' as u;
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_opnening_hours_clu.dart';
import 'package:blaxity/views/screens/screen_clubs/screen_upload_logo_club.dart';
import 'package:blaxity/views/screens/screen_clubs_home.dart';
import 'package:blaxity/views/screens/screen_individual/screen_location_individual.dart';
import 'package:blaxity/views/screens/screen_splash.dart';
import 'package:blaxity/widgets/custom_splash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/custom_selectable_button.dart';

class ScreenEventEditProfile extends StatelessWidget {
  ControllerHome controllerHome = Get.find<ControllerHome>();
  u.Club? club;

  @override
  Widget build(BuildContext context) {
    // controllerHome.fetchUserInfo();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Image.asset(
              height: Get.height * .23,
              "assets/images/image_profile_appBar.png"),
        ),
        body: Obx(() {
          if (controllerHome.isLoading.value||controllerHome.user.value == null) {
            return Center(
                child: CircularProgressIndicator(
              color: Color(0xFFA26837),
            ));
          } else {
            u.User user = controllerHome.user.value!.user;
            if (user.userType == "club_event_organizer") {
              club = controllerHome.user.value!.user.clubs!.first;
            }
            return RefreshIndicator(
              color: Color(0xFFA26837),
              onRefresh: () async {
                await controllerHome.fetchUserInfo();
              },
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      text: 'Account Settings',
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor,
                    ).marginSymmetric(
                      vertical: 10.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Phone Number",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Text(
                          user.phone ?? "Not Added",
                          style: AppFonts.resendEmailStyle,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    Row(
                      children: [
                        Text(
                          "Email",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Text(
                          user.email ?? "No Added",
                          style: AppFonts.resendEmailStyle,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ).marginOnly(
                      top: 20.h,
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    if (user.verified == "1")
                      Text(
                        "Verify an Email to help secure your account.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                    if (user.userType == "club_event_organizer")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ScreenUploadLogoClub(
                                user: user,
                              ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Logo",
                                  style: AppFonts.titleSetting,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                )
                              ],
                            ).marginOnly(
                              top: 20.h,
                            ),
                          ),
                          Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                          GradientText(
                            text: 'Opening Hours',
                            style: AppFonts.subscriptionTitle,
                            gradient: AppColors.buttonColor,
                          ).marginSymmetric(
                            vertical: 10.h,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(ScreenOpeningHours(
                                user: user,
                              ));
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Opening",
                                      style: AppFonts.titleSetting,
                                    ),
                                    Spacer(),
                                    Text(
                                      club!.openingTime ?? "No Added",
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                                Row(
                                  children: [
                                    Text(
                                      "Closing",
                                      style: AppFonts.titleSetting,
                                    ),
                                    Spacer(),
                                    Text(
                                      club!.closingTime ?? "No Added",
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    )
                                  ],
                                ).marginOnly(
                                  top: 20.h,
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                        ],
                      ),
                    // GradientText(text: 'DISCOVERY',
                    //   style: AppFonts.subscriptionTitle,
                    //   gradient: AppColors.buttonColor,).marginSymmetric(
                    //   vertical: 25.h,
                    // ),
                    if (user.userType == "club_event_organizer")
                      InkWell(
                        onTap: () {
                          Get.to(ScreenLocationIndividual(
                            step: 'Update',
                            user: user,
                          ));
                        },
                        child: Row(
                          children: [
                            Text(
                              "Location",
                              style: AppFonts.titleSetting,
                            ),
                            Spacer(),
                            Text(
                              club!.location ?? "No Added",
                              style: TextStyle(
                                color: Color(0xffCDCDCD),
                                fontSize: 12.sp,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ).marginSymmetric(vertical: 10.h),

                    GradientText(
                      text: 'BILLING & PAYMENT',
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor,
                    ).marginSymmetric(
                      vertical: 25.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Billing & Payment",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Icon(
                          size: 15.h,
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    GradientText(
                      text: 'HISTORY',
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor,
                    ).marginSymmetric(
                      vertical: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Check your history",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    GradientText(
                      text: 'CONTACT US',
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor,
                    ).marginSymmetric(
                      vertical: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Contact Support",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    GradientText(
                      text: 'Legal',
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor,
                    ).marginSymmetric(
                      vertical: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Legal Preferences",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    GradientText(
                      text: 'Privacy Policy',
                      style: AppFonts.subscriptionTitle,
                      gradient: AppColors.buttonColor,
                    ).marginSymmetric(
                      vertical: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "View Our Privacy Policy",
                          style: AppFonts.titleSetting,
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Divider(color: Colors.white,thickness: 0.7,).marginOnly(bottom: 0,),

                    SizedBox(
                      height: 50.h,
                    ),
                    CustomSplashButton(
                      onTap: () async {
                        Get.defaultDialog(
                          radius: 20,
                          titleStyle: TextStyle(
                              color: AppColors.appColor, fontSize: 30.sp,fontWeight: FontWeight.w700),
                          titlePadding: EdgeInsets.only(top: 20.h),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 20.w),
                          backgroundColor: AppColors.chatColor,
                          title: "Logout",
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GradientText(
                                text: "Are you sure you want to\nLogout?",
                                style: AppFonts.subscriptionTitle.copyWith(fontSize: 25.sp),
                                gradient: AppColors.buttonColor,
                              ).marginOnly(bottom: 30.h),
                              Row(children: [
                                Expanded(
                                    child: CustomSelectbaleButton(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        isSelected: true,
                                        width: Get.width,
                                        height: 35.h,
                                        strokeWidth: 1,
                                        textSize: 12.sp,
                                        gradient: AppColors.buttonColor,
                                        titleButton: "No")),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: CustomSelectbaleButton(
                                  borderRadius: BorderRadius.circular(10.r),
                                  isSelected: false,
                                  width: Get.width,
                                  height: 35.h,
                                  strokeWidth: 1,
                                  textSize: 12.sp,
                                  gradient: AppColors.buttonColor,
                                  titleButton: "Yes",
                                  onTap: () async {
                                    await ControllerLogin.logoutUser()
                                        .then((value) async {
                                      await ControllerLogin.logout();

                                      Get.find<ControllerHome>().user.value =
                                          null;

                                      Get.find<ControllerHome>().dispose();
                                      Get.find<EventController>().dispose();
                                      Get.find<ControllerGetUserAllData>()
                                          .dispose();
                                      Get.find<BottomNavController>()
                                              .selectedIndex ==
                                          0;
                                      Get.find<BottomNavClubController>()
                                              .selectedIndex ==
                                          0;
                                    });
                                  },
                                )),
                              ]).marginSymmetric(horizontal: 20.w)
                            ],
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(20),
                      width: Get.width,
                      height: 54.h,
                      strokeWidth: 1,
                      gradient: AppColors.buttonColor,
                      titleButton: "Logout",
                    ).marginSymmetric(
                      horizontal: 20.w,
                    ),
                    CustomSplashButton(
                      onTap: () async {
                        Get.defaultDialog(
                          radius: 20,
                          titleStyle: TextStyle(
                              color: AppColors.appColor, fontSize: 30.sp,fontWeight: FontWeight.w700),
                          titlePadding: EdgeInsets.only(top: 20.h),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 20.w),
                          backgroundColor: AppColors.chatColor,
                          title: "Logout",
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GradientText(
                                text: "Are you sure you want to\nDelete your account?",
                                style: AppFonts.subscriptionTitle.copyWith(fontSize: 25.sp),
                                gradient: AppColors.buttonColor,
                              ).marginOnly(bottom: 30.h),
                              Row(children: [
                                Expanded(
                                    child: CustomSelectbaleButton(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                        isSelected: true,
                                        width: Get.width,
                                        height: 35.h,
                                        strokeWidth: 1,
                                        textSize: 12.sp,
                                        gradient: AppColors.buttonColor,
                                        titleButton: "No")),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: CustomSelectbaleButton(
                                      borderRadius: BorderRadius.circular(10.r),
                                      isSelected: false,
                                      width: Get.width,
                                      height: 35.h,
                                      strokeWidth: 1,
                                      textSize: 12.sp,
                                      gradient: AppColors.buttonColor,
                                      titleButton: "Yes",
                                      onTap: () async {                        await ControllerDeleteUser().DeleteUser().then((value) {
                                        Get.offAll(ScreenSplash());
                                        Get.find<ControllerHome>().user.value = null;
                                        Get.find<ControllerHome>().dispose();
                                        Get.find<EventController>().dispose();
                                        Get.find<ControllerGetUserAllData>().dispose();
                                        Get.find<BottomNavController>().selectedIndex == 0;
                                        Get.find<BottomNavClubController>().selectedIndex ==
                                            0;
                                      });
                                      },
                                    )),
                              ]).marginSymmetric(horizontal: 20.w)
                            ],
                          ),
                        );

                      },
                      borderRadius: BorderRadius.circular(20),
                      width: Get.width,
                      height: 54.h,
                      strokeWidth: 1,
                      gradient: AppColors.buttonColor,
                      titleButton: "Delete Account",
                    ).marginSymmetric(
                      vertical: 15.h,
                      horizontal: 20.w,
                    ),
                  ],
                ).marginSymmetric(
                  horizontal: 15.sp,
                  vertical: 15.sp,
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
