import 'dart:developer';
import 'dart:ui';

import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_couple_profile.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_single_user_profile.dart';
import 'package:blaxity/views/layouts/layout_club_profile.dart';
import 'package:blaxity/views/screens/screen_event_edit_profile.dart';
import 'package:blaxity/views/screens/screen_start_verification.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../constants/ApiEndPoint.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../layouts/item_profile_details.dart';
import '../../screens/screen_match_person_profile.dart';
import '../../screens/screen_edit_profile.dart';
import '../../screens/screen_subscription_type_profile.dart';

class LayoutProfile extends StatefulWidget {
  const LayoutProfile({super.key});

  @override
  State<LayoutProfile> createState() => _LayoutProfileState();
}

class _LayoutProfileState extends State<LayoutProfile> {
  ControllerHome _controllerHome = Get.put(ControllerHome());
  int _selectedButtonIndex = -1;

  // void _onAvatarTap(int index) {
  //   setState(() {
  //     _selectedButtonIndex = index;
  //     if (_selectedButtonIndex == 3)
  //       Get.to(ScreenMatchPersonProfile());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // _controllerHome.fetchUserInfo();
    // User user=_.user;
    // log(_controllerHome.user.value!.user.reference.shareLink);
    // log(_controllerHome.user.value!.user.reference.generatedQrCode!);

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.white,
        //   ),
        // ),
        actions: [
          IconButton(onPressed: () {
            Get.to(ScreenEditProfile());
          }, icon: Icon(CupertinoIcons.pencil, color: Colors.white,)),
          IconButton(onPressed: () {
            Get.to(ScreenEventEditProfile());
            // ControllerLogin.logout().then((value){
            //   Get.find<ControllerHome>().dispose();
              // Get.find<ControllerHome>().user.value=null;
            // });
          }, icon: Icon(CupertinoIcons.settings, color: Colors.white,)),
        ],
        title: Image.asset(
            height: height * .23, "assets/images/image_profile_appBar.png"),
      ),
      body: Obx(() {

         if(_controllerHome.user.value==null){
          return
          SizedBox();
        }
         else {
           var user = _controllerHome.user.value!.user;
           log(user.userType.toString());

           return (user.userType=="couple")?
           LayoutCoupleProfile(coupleId: user.coupleId!,)
               :LayoutSingleUserProfile(id: user.id!,);
         }}),
    );
  }
}
