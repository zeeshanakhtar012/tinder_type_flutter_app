import 'package:blaxity/controllers/controller_get_couple.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/views/screens/screen_userChat.dart';
import 'package:blaxity/widgets/custom_splash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/firebase_utils.dart';
import '../../controllers/controller_home.dart';
import '../../models/match_response.dart';
import '../../models/user.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_selectable_button.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../home_page/home_page.dart';

class ScreenMatchPersonProfile extends StatelessWidget {
  MatchResponse matchResponse;
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Spacer(),
            Text("It’s a match", style: AppFonts.subscriptionTitle),
            Text(matchResponse.message ?? "No Match", style: AppFonts.subtitle),
            SizedBox(height: 20.h), // Add space between text and row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 100.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 85.w,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 40.r,
                            child: Container(
                              height: 110.02.h,
                              width: 110.02.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 6,
                                    color: Color(0xFFA26837),
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return AppColors.buttonColor.createShader(
                                          bounds);
                                    },
                                    child: Icon(
                                      Icons.person,
                                      size: 24.h,
                                    ),
                                  ),
                                  Text(matchResponse.userFLetter ?? "No User",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 100.w,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 40.r,
                            child: Container(
                              height: 110.02.h,
                              width: 110.02.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 6,
                                    color: Color(0xFFA26837),
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return AppColors.buttonColor.createShader(
                                          bounds);
                                    },
                                    child: Icon(
                                      Icons.group,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    matchResponse.matchFLetter ?? "No User",),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 150.w,
                          top: 35.h,
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonColor,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                                "assets/icons/icon_flah.svg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(), // Add space between row and buttons
            Obx(() {
              return CustomSplashButton(
                onTap: () async {
                  isLoading.value = true;
                  if (Get
                      .find<ControllerHome>()
                      .user
                      .value!
                      .user
                      .goldenMember == 1 && Get
                      .find<ControllerHome>()
                      .user
                      .value!
                      .user
                      .message_count! > 0) {
                    if (matchResponse.match!.matchedCoupleId != null) {
                      await Get.find<CoupleController>().fetchCoupleDetails(
                          matchResponse.match!.matchedCoupleId.toString())
                          .then((userCouple) async {
                        List<User> userList = userCouple.data;
                        if (userList.length > 1) {
                          User currentUser = Get
                              .find<ControllerHome>()
                              .user
                              .value!
                              .user;
                          if (currentUser.userType == "couple") {
                            await Get.find<CoupleController>()
                                .fetchCoupleDetails(
                                currentUser.coupleId.toString())
                                .then((myCouple) {
                              userList = myCouple.data.where((e) =>
                              e.id !=
                                  currentUser.id)
                                  .toList();
                              Get.to(ScreenUserChat(usersList: userList));
                            });
                          }
                          else {
                            Get.to(ScreenUserChat(usersList: userList));
                          }
                        } else {
                          FirebaseUtils.showError(
                              "Your partner is not available");
                        }
                      });
                    } else {
                      List<User> userList = [];
                      UserResponse userResponse = await Get.find<
                          ControllerHome>().fetchUserByIdProfile(
                          matchResponse.match!.userId!);
                      userList = [userResponse.user];
                      User currentUser = Get
                          .find<ControllerHome>()
                          .user
                          .value!
                          .user;
                      if (currentUser.userType == "couple") {
                        await Get.find<CoupleController>().fetchCoupleDetails(
                            currentUser.coupleId.toString()).then((myCouple) {
                          userList = myCouple.data.where((e) =>
                          e.id !=
                              currentUser.id)
                              .toList();
                          Get.to(ScreenUserChat(usersList: userList));
                        });
                      }
                      else {
                        Get.to(ScreenUserChat(usersList: userList));
                      }
                    }
                  }
                  else {
                    FirebaseUtils.showError(
                        "You have to become a golden member to chat with this user");
                    Get.to(ScreenSubscription(isHome: true,));
                  }
                  isLoading.value = false;
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                isLoading: isLoading.value,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Message",
              );
            }).marginSymmetric(
              vertical: 12.h,
            ),
            CustomButton(
              // isBorder: true,
              buttonColor: Color(0xFF353535),


              text: "Keep swiping",
              textColor: Colors.white,
              onTap: () {
                Get.back();
              },
            ).marginSymmetric(
              vertical: 3.sp,
            ),
          ],
        ).paddingSymmetric(horizontal: 15.sp, vertical: 15.sp),
      ),
    );
  }

  ScreenMatchPersonProfile({
    required this.matchResponse,
  });
}
