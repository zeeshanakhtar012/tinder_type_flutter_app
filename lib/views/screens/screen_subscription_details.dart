import 'package:blaxity/controllers/controller_payment.dart';
import 'package:blaxity/models/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/firebase_utils.dart';
import '../../constants/fonts.dart';
import '../../controllers/authentication_controllers/controller_sign_in_.dart';
import '../../controllers/controller_home.dart';
import '../../models/user.dart';
import '../../widgets/custom_selectable_button.dart';
import '../home_page/home_page.dart';
import '../layouts/item_subscription_details.dart';

class ScreenSubscriptionDetails extends StatelessWidget {
  Subscription subscription;
bool isHome;
  ScreenSubscriptionDetails({
    required this.subscription,
    required this.isHome
  });


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back(
                result: true,
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Image.asset(
              height: height * .23, "assets/text_icons/blaxity_text.png"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                text:
                'See who likes you, who’s\nonline and connect instantly. ',
                style: AppFonts.subscriptionTitle,
                gradient: AppColors.buttonColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonColor,
                    ),
                  ),
                  GradientText(
                    text: 'BLAXITY GOLD',
                    style: AppFonts.subscriptionBlaxityGold,
                    gradient: AppColors.buttonColor,
                  ).marginSymmetric(
                    horizontal: 8.w,
                    vertical: 10.h,
                  ),
                  Container(
                    height: 5.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonColor,
                    ),
                  ),
                ],
              ).marginSymmetric(
                vertical: 10.h,
              ),
              ItemSubscriptionDetails(subscription: subscription,),
              CustomSelectbaleButton(
                onTap: ()async {
                  if (isHome==true) {
                    Get.back();
                  }
                  else{

                    String? userType = await ControllerLogin.getUserType();
                    if (userType == "couple") {
                      UserResponse userResponse = await Get.find<ControllerHome>().fetchUserProfile();
                      if (userResponse.has_couple == "1") {
                        Get.offAll(HomeScreen());
                      }
                      else{
                        FirebaseUtils.showError( "Please wait for your partner to add you to their profile.");
                      }

                    }
                    else {
                      FirebaseUtils.showError("Wait until admin allow you ");

                    }

                  }
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width*.8,
                height: 54.h,
                strokeWidth: 1,
                gradient: AppColors.buttonColor,
                titleButton: "Skip for now",
              ).marginSymmetric(
                vertical: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
