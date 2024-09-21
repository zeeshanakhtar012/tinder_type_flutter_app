import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/controllers/subscription_controller.dart';
import 'package:blaxity/models/subscription.dart';
import 'package:blaxity/views/screens/screen_clubs_home.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/controller_payment.dart';
import '../../models/user.dart';
import '../../widgets/custom_selectable_button.dart';
import '../home_page/home_layouts/layout_blog.dart';
import '../home_page/home_layouts/layout_home.dart';
import '../home_page/home_layouts/layout_profile.dart';
import '../home_page/home_page.dart';
import '../layouts/item_subscription/item_subscription.dart';

class ScreenSubscription extends StatelessWidget {
  bool isHome;
  RxInt selectedPlan = 1.obs;
  RxString userType = "".obs;

  checkUserType() async {
    userType.value = (await ControllerLogin.getUserType())!;
  }

  @override
  Widget build(BuildContext context) {
    checkUserType();

    SubscriptionController subscriptionController = Get.put(
        SubscriptionController());
    subscriptionController.fetchSubscriptions();
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
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
              alignment: Alignment.centerRight,
              height: 50.h,
              width: 180.w,
              "assets/images/balxity-splash.png"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: GradientText(text:
                "See who likes you,\nwho’s online and connect instantly. ",
                  textAlign: TextAlign.center,
                  gradient: AppColors.buttonColorSubscription,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold
                    // color:
                  ),
                )
            ).marginSymmetric(horizontal: 40.w),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 1.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonColor,
                  ),
                ),
                GradientText(
                  text: 'BLAXITY GOLD',
                  style: AppFonts.subscriptionBlaxityGold,
                  gradient: AppColors.buttonColorSubscription,
                ).marginSymmetric(
                  horizontal: 8.w,
                ),
                Container(
                  height: 1.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonColor,
                  ),
                ),
              ],
            ).marginSymmetric(
              vertical: 15.h,
            ),
            Expanded(
              child: Obx(() {
                return (subscriptionController.isLoading.value)
                    ? Center(child: CircularProgressIndicator())
                    : (subscriptionController.subscriptions.isEmpty) ? Center(
                  child: Text("No Subscriptions", style: TextStyle(color: Colors
                      .white),),) : ListView.builder(
                  itemCount: subscriptionController.subscriptions.length,
                  // shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Subscription subscription = subscriptionController
                        .subscriptions[index];
                    return ItemSubscription(
                      subscription: subscription, isHome: isHome,);
                  },);
              }),
            ),


            Obx(() {
              return(userType.value=="couple")? CustomSelectbaleButton(
                onTap: () async {
                  if (isHome == true) {
                    Get.back();
                  }
                  else {
                    ;
                    if (userType == "couple") {
                      UserResponse userResponse = await Get.find<
                          ControllerHome>().fetchUserProfile();
                      if (userResponse.has_couple == "1") {
                        Get.offAll(HomeScreen());
                      }
                      else {
                        FirebaseUtils.showError(
                            "Please wait for your partner to add you to their profile.");
                      }
                    }
                    else {
                      FirebaseUtils.showError("Wait until admin allow you ");
                    }
                  }
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Skip for now",
              ):SizedBox();
            }).paddingOnly(top: 20.h),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }

  ScreenSubscription({
    required this.isHome,

  });
}
