import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/chat_controller.dart';
import 'package:blaxity/views/screens/archieved/item_chat_archieved_personal_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/colors.dart';
import '../../../models/last_message.dart';
import '../../../widgets/custom_drawer.dart';
import '../../home_page/home_layouts/layout_chat.dart';
import '../../layouts/layout_group_chat.dart';
import '../../layouts/layout_personal_chat.dart';

class LayoutChatArchived extends StatelessWidget {
  List<LastMessage> archivedCouple;
  List<LastMessage> archivedSingle;

  @override
  Widget build(BuildContext context) {
    ChatPersonalController chatController = Get.put(ChatPersonalController());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/images/image_profile_appBar.png",
          height: Get.height * 0.23,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 36.h,
                margin: EdgeInsets.only(bottom: 10.h),
                width: 175.w,
                decoration: BoxDecoration(
                    color: Color(0xFF353535),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.transparent,
                    )
                ),
                child: TabBar(indicatorPadding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: AppColors.buttonColor,
                      border: Border.all(
                        color: Colors.transparent,
                      )
                  ),
                  tabs: [
                    Tab(text: 'Messages'),
                    Tab(text: 'Groups'),
                  ],
                ),
              ).marginOnly(
                top: 15.sp,
              ),
            ),
            Expanded(
                child: Obx(() {
                  return (chatController.isLoading.value)?Center(child: CircularProgressIndicator(),):TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      LayoutPersonalChat(
                        lastMessageList: archivedSingle,),
                      LayoutGroupChat(
                        lastMessageList: archivedCouple),
                    ],
                  );
                })
            ),
          ],
        ),
      ),
    );
  }

  LayoutChatArchived({
    required this.archivedCouple,
    required this.archivedSingle,
  });
}
