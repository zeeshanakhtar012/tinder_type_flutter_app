import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../item_chat.dart';

class ItemGroupMessages extends StatelessWidget {
  const ItemGroupMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.archivebox_fill)),
            Text("Archived", style: AppFonts.subscriptionTitle,),
          ],
        ).marginOnly(
          top: 15.sp,
        ),
        ItemChat(
          time: "7:30 PM",
          messageCounter: "4",
          subtitleChat: "Hello There",
          titleChat: "Group Test",
          imageUrl: "assets/icons/chat_person.png", onTap: () {  },
        ),
        // GradientDivider(gradient: AppColors.buttonColor, width: Get.width,
        //   thickness: 0.25,
        // ),
        // ItemChat(
        //   time: "7:30 PM",
        //   messageCounter: "4",
        //   subtitleChat: "Hello There",
        //   titleChat: "Group Test 2",
        //   imageUrl: "assets/icons/chat_person.png",
        // ),
      ],
    );
  }
}
