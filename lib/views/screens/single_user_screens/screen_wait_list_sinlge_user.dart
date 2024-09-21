import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_blaxiter_subscription_single_user.dart';
import 'package:blaxity/widgets/custom_button.dart';
import 'package:blaxity/widgets/custom_selectable_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_divider_gradient.dart';
import '../screen_signin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:share_plus/share_plus.dart';
class ScreenWaitListSingleUser extends StatelessWidget {
  const ScreenWaitListSingleUser({super.key});

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
            height: Get.height * .23,
            "assets/images/image_profile_appBar.png",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: GradientText(text: "You’re on the waitlist", style: AppFonts.subscriptionBlaxityGold,
                  gradient: AppColors.buttonColor,
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Don’t do queues? Join us as a Member.", style: AppFonts.resendEmailStyle,)),
              SvgPicture.asset("assets/icons/icon_wait_list.svg").marginOnly(
                top: 10.sp,
              ),
              CustomSelectbaleButton(
                onTap: (){
                  // Get.to(ScreenBlaxiterSubscription());
                  Get.to(ScreenSubscription(isHome: false,));
                },
                isSelected: true,
                titleButton: "Become a Blaxiter",
                gradient: AppColors.buttonColor, width: Get.width,
                height: 52.h, strokeWidth: 3,
                borderRadius: BorderRadius.circular(20),
                
              ).marginOnly(
                top: 20.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  gradient: AppColors.buttonColor,
                  text: "Skip the line", style: AppFonts.subscriptionBlaxityGold,).marginOnly(
                  top: 20.sp,
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Complete the task to expedite your application.", style: AppFonts.resendEmailStyle,)),
              SvgPicture.asset("assets/icons/icon_wait_list_02.svg").marginOnly(
                top: 10.sp,
              ),

              GestureDetector(
                onTap: (){
                  shareAppLink();
                },
                child: Row(
                  children: [
                    Image.asset("assets/icons/icon_share.png"),
                    Text("Share link ", style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        decoration: TextDecoration.underline
                    ),).marginOnly(
                      left: 10.w,
                    )
                  ],
                ).marginOnly(
                  top: 10.sp,
                ),
              ),
              GradientDivider(thickness: 0.3,
                  gradient: AppColors.whiteColorGradient,
                  width: Get.width).marginSymmetric(
                horizontal: 8.w,
                vertical: 12.h,
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
 // Add this package for sharing functionality

  Future<String> createAppLink() async {
    // This link will be the base link without any specific user data
    final String baseLink = "https://blaxity.page.link/content";

    final dynamicLink = {
      "dynamicLinkInfo": {
        "domainUriPrefix": "https://blaxity.page.link",
        "link": baseLink,
        "androidInfo": {"androidPackageName": "codergize.com.blaxity"},
        "iosInfo": {"iosBundleId": "codergize.com.blaxity"}
      },
      "suffix": {"option": "SHORT"}
    };

    final response = await http.post(
      Uri.parse(
          'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyCQfJi4kelyyF5MeyyQ43nDrzUKbneQ_Dg'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dynamicLink),
    );
    log(response.body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      log(responseData['shortLink']);
      return responseData['shortLink'];
    } else {
      throw Exception('Failed to create dynamic link');
    }
  }

  void shareAppLink() async {
    try {
      String appLink = await createAppLink();
      Share.share('Check out our app: $appLink');
    } catch (e) {
      log('Failed to share app link: $e');
    }
  }

}
