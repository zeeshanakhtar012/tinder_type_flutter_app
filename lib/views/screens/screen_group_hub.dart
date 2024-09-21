import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/views/screens/screen_create_group.dart';
import 'package:blaxity/views/screens/screen_group_request.dart';
import 'package:blaxity/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../../widgets/custom_drawer.dart';
import '../layouts/item_event/event_button/item_event.dart';
import '../layouts/item_group/item_group.dart';

class ScreenGroupHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    GroupController groupController = Get.put(GroupController());

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (Get.find<ControllerHome>().user.value!.user.goldenMember == 1 &&
                  Get.find<ControllerHome>().user.value!.user.group_count! > 0) {
                Get.to(ScreenCreateGroup());
              } else {
                FirebaseUtils.showError(
                  "Only Golden members can create group up to 5 for lifetime.",
                );
              }
            },
            icon: Icon(
              Icons.person_add_alt,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              style: AppFonts.titleLogin,
              text: "Group Hub",
              gradient: AppColors.buttonColor,
            ),
            Text(
              "Explore and Connect with Like-Minded Communities.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 47.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff353535),
                  )
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a group',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  groupController.fetchGroups(search: value);
                },
                onSubmitted: (value) {},
              ),
            ).marginOnly(
              top: 20.h,
            ),
            Obx(() {
              return RefreshIndicator(
                color: Color(0xFFA7713F),
                onRefresh: () {
                  groupController.fetchGroups();
                  return Future.value();
                },
                child: (groupController.isLoading.value)
                    ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFA7713F),
                  ),
                )
                    : groupController.groups.isEmpty
                    ? Center(child: Text("No Groups"))
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: groupController.groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemGroup(
                      group: groupController.groups[index],
                    );
                  },
                ),
              );
            }).marginOnly(
              top: 10.h,
            ),
          ],
        ).marginSymmetric(horizontal: 20.w),
      ),
    );
  }
}
