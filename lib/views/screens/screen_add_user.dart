import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/views/screens/screen_add_user_anonymousley.dart';
import 'package:blaxity/views/screens/screen_add_user_link.dart';
import 'package:blaxity/views/screens/screen_add_user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_selectable_button.dart';
import '../layouts/item_invite_user_anonymous.dart';

class ScreenAddUser extends StatelessWidget {
  const ScreenAddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Connect with\nOthers", style: AppFonts.titleLogin,),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Add users anonymously, by username, or with\na unique link", style: AppFonts.subtitle,),
            ).marginSymmetric(
              vertical: 5.sp,
            ),
            ItemInviteUserAnonymous(text: 'Add by username', onTap: () {
              Get.to(ScreenAddUserName());
            },).paddingOnly(
              top: 25.h,
            ),
            ItemInviteUserAnonymous(text: 'Add user anonymously', onTap: () {
              Get.to(ScreenAddUserAnonymously());
            },).paddingSymmetric(
              vertical: 30.sp,
            ),
            ItemInviteUserAnonymous(text: 'Add by link', onTap: () {
              Get.to(ScreenAddUserLink());
            },).paddingSymmetric(
              vertical: 5.sp,
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }
}
