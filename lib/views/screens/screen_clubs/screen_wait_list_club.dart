import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';

class ScreenWaitListClub extends StatelessWidget {
User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none, color: Colors.white,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_list, color: Colors.white,)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(text: "You’re on the waitlist", style: AppFonts.subscriptionBlaxityGold, gradient: AppColors.buttonColor),
            Text("Don’t do queues? Join us as a Member.", style: AppFonts.subtitle,),
            SvgPicture.asset("assets/icons/icon_wait_list_individual.svg").marginOnly(
              top: 15.sp,
            ),
            Spacer(),
            CustomButton(
              onTap: (){
                Get.to(ScreenSubscription(isHome: false,));
              },
              text: "Become a Blaxiter",
              textColor: Colors.white,
              buttonGradient: AppColors.buttonColor,
            ).marginOnly(
              top: 20.h,
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
      ),
    );
  }

ScreenWaitListClub({
    required this.user,
  });
}
