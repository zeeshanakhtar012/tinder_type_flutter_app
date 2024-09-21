import 'package:blaxity/views/screens/screen_clubs_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../layouts/item_subscription/item_subscription.dart';

class ScreenBlaxitySubscriptionClub extends StatelessWidget {
   ScreenBlaxitySubscriptionClub({super.key});
   final List<String> detailsSingleClub = [
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
    return    SafeArea(child: Scaffold(
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
          height: Get.height * .23,
          "assets/images/image_profile_appBar.png",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                style: AppFonts.subscriptionBlaxityGold,
                textAlign: TextAlign.start,
                "See who likes you and match\nwith them instantly with\nBlaxity gold.",).marginSymmetric(
                vertical: 10.sp,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // ItemSubscription(
                  //   subscriptionDurationTitle: '1 Boost',
                  //   subscriptionPriceTitle: '14.99',
                  //   subscriptionPerWeekTitle: null,
                  //   // subscriptionDescriptionTitle: null,
                  //   isImage: true,
                  //   imageUrl: "assets/icons/icon_right_tick_white.svg",
                  //   // onTap: () {},
                  //   // buttonText: "Boost",
                  // ).marginSymmetric(
                  //   horizontal: 5.sp,
                  // ),
                  // ItemSubscription(
                  //   subscriptionDurationTitle: '5 Boost',
                  //   subscriptionPriceTitle: '54.99',
                  //   subscriptionPerWeekTitle: null,
                  //   // subscriptionDescriptionTitle: null,
                  //   isImage: true,
                  //   imageUrl: "assets/icons/icon_right_tick_white.svg",
                  //   // onTap: () {},
                  //   // buttonText: "Boost",
                  // ).marginSymmetric(
                  //   horizontal: 5.sp,
                  // ),
                  // ItemSubscription(
                  //   subscriptionDurationTitle: '10 Boost',
                  //   subscriptionPriceTitle: '104.99',
                  //   subscriptionPerWeekTitle: null,
                  //   // subscriptionDescriptionTitle: null,
                  //   isImage: true,
                  //   imageUrl: "assets/icons/icon_right_tick_white.svg",
                  //   // onTap: () {},
                  //   // buttonText: "Boost",
                  // ).marginSymmetric(
                  //   horizontal: 5.sp,
                  // ),
                ],
              ),
            ).marginSymmetric(
              vertical: 8.sp,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.33),
                border: Border.all(
                  color: Color(0xFFA7713F),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                            height: 20.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFA7713F),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Included with Blaxity Gold",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: detailsSingleClub.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Icon(
                              Icons.fiber_manual_record),
                          Text(detailsSingleClub[index], style: TextStyle(
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
                    left: 20.sp,
                    top: 15.sp,
                  ),
                ],
              ),
            ).marginSymmetric(
              vertical: 5.sp,
            ),
            CustomButton(
              onTap: (){
                Get.offAll(ScreenClubsHome());
                // Get.to(ScreenBlaxiterSubscription());
              },
              text: "Continue - US\$14.99 total",
              textColor: Colors.white,
              buttonGradient: AppColors.buttonColor,
            ).marginOnly(
              top: 20.sp,
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    ));

  }
}
