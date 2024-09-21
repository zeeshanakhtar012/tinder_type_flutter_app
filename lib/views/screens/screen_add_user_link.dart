import 'dart:convert';
import 'dart:developer';

import 'package:blaxity/controllers/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:share_plus/share_plus.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/authentication_controllers/controller_sign_in_.dart';
import '../../widgets/custom_selectable_button.dart';
import '../layouts/item_invite_user_anonymous.dart';

class ScreenAddUserLink extends StatelessWidget {

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
              child: Text("Add by Link", style: AppFonts.titleLogin,),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Invite by link", style: AppFonts.subtitle,),
            ),
            ItemInviteUserAnonymous(
              isImage: true,
              imageUrl: 'assets/icons/icon_copy_link.svg',
              text: 'Copy link', onTap: () async {
                String shareLink=await createDynamicLink();
              Share.share(shareLink);
            },).marginOnly(
                top: 50.h
            ),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }
  RxString link = ''.obs;
  Future<String> createDynamicLink() async {
    int? id = await ControllerLogin.getUid();
    int _id=id!;
    String? userType = await ControllerLogin.getUserType(); // Assuming you have a method to get the userType

    if (userType=="couple") {
      _id=Get.find<ControllerHome>().user.value!.user.coupleId!;
    }

    link.value = "https://blaxity.page.link/content?data=${_id}&type=${userType}";

    final dynamicLink = {
      "dynamicLinkInfo": {
        "domainUriPrefix": "https://blaxity.page.link",
        "link": link.value,
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

}
