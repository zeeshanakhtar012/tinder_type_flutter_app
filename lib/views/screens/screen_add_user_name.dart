import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/user_controller.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/custom_selectable_button.dart';

class ScreenAddUserName extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Add by Username", style: AppFonts.titleLogin,),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Invite by username", style: AppFonts.subtitle,),
            ).marginSymmetric(
              vertical: 5.sp,
            ),
            MyInputField(
              hint: "add by username",
              controller: userNameController,
              suffix: Icon(Icons.person_add_alt, color: Colors.white,),
            ),
            GradientDivider(
                thickness: .3,
                gradient: AppColors.buttonColor, width: MediaQuery
                .sizeOf(context)
                .width * .85),
            Spacer(),
            Obx(() {
              return CustomSelectbaleButton(
                isLoading: userController.isLoading.value,
                onTap: () async {
                  String username = userNameController.text;
                  if (username.isEmpty) {
                    FirebaseUtils.showError("Please Enter UserName");
                  }
                  else{
                    await  userController.connect(username);
                  }
                },
                borderRadius: BorderRadius.circular(20),
                width: Get.width,
                height: 54.h,
                strokeWidth: 1,
                isSelected: true,
                gradient: AppColors.buttonColor,
                titleButton: "Confirm",
              );
            }),
          ],
        ).marginSymmetric(
          horizontal: 15.sp,
          vertical: 15.sp,
        ),
      ),
    );
  }
}
