import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_divider_gradient.dart';

class ScreenSubscriptionType extends StatelessWidget {
   ScreenSubscriptionType({super.key});
  final List<String> details = [
    'Unlimited Profiles',
    'Unlimited Chats',
    'See who viewed you',
    'See who is online now',
    'Extended Filters',
    'Explore private Event',
    'Extended profile',
    'See other profile photos',
    'Appear higher in search',
    'See who\'s attending Public Events',
    'Audio / Video Call',
    'Join Group Chats',
    'Find exclusive Singles',
    'Send 20 Messages Before Matching!',
    'And more....'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Image.asset(
              height: Get.height * .23, "assets/images/image_profile_appBar.png"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: 'Subscription type',
                  style: AppFonts.subscriptionBlaxityGold,
                  gradient: AppColors.buttonColor,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Stay Informed: Manage Your Subscription Plan", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),),
              ),
              Container(
                height: Get.height*.6,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFA7713F),
                  )
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA7713F),
                                    // border: Border.all(
                                    //   color: Color(0xFFA7713F),
                                    // ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Included with Blaxity Gold",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Icon(
                                // size: 15.h,
                                Icons.fiber_manual_record),
                            Text(details[index], style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),).marginOnly(
                              left: 6.sp,
                            ),
                          ],
                        );
                      },
                    ).marginOnly(
                      left: 10.sp,
                      top: 15.sp,
                    ),
                  ],
                ),
              ).marginOnly(
                top: 20.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: 'Remaining messages',
                  style: AppFonts.subscriptionBlaxityGold,
                  gradient: AppColors.buttonColor,
                ),
              ).marginOnly(
                top: 20.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("0/20", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),),
              ),
              GradientDivider(
                thickness: 0.4, gradient: AppColors.buttonColor, width: Get.width,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: 'Renewal date',
                  style: AppFonts.subscriptionBlaxityGold,
                  gradient: AppColors.buttonColor,
                ),
              ).marginOnly(
                top: 20.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Your subscription plan is set to renew on May 25th,\n2024, at 12:00 PM. Keep enjoying uninterrupted\naccess!", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),),
              ),
              GradientDivider(
                thickness: 0.4, gradient: AppColors.buttonColor, width: Get.width,
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }
}
