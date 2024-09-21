import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/views/layouts/item_group_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../models/group.dart';
import '../layouts/item_event/event_button/item_event.dart';

class ScreenGroupRequests extends StatelessWidget {
  Group group;
  // JoinRequest joinRequest;
  GroupController groupController =Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    groupController.fetchGroupRequests(group.id);
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
        body: RefreshIndicator(
          color: AppColors.appColor,
          onRefresh: () {
            return groupController.fetchGroupRequests(group.id);
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height*.3,
                  width: Get.width,
                  margin: EdgeInsets.symmetric(vertical: 10.h,),

                  decoration: BoxDecoration(
                      color: Color(0xFF1d1d1d),
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${APiEndPoint.imageUrl+group.img}"))

                  ),),
                Text("${group.title}", style: AppFonts.subscriptionBlaxityGold,),
                Text("Request", style: AppFonts.subscriptionTitle,).marginOnly(
                  top: 30.sp,
                ),
                Obx(() {
                  if (groupController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (groupController.joinRequests == null || groupController.joinRequests.isEmpty) {
                    return Center(child: Text('No join requests available'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: groupController.joinRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      JoinRequest jointRequest = groupController.joinRequests[index];
                      return ItemGroupRequest(group: group, jointRequest: jointRequest);
                    },
                  );
                })

              ],
            ).marginSymmetric(
              horizontal: 15.sp,
              vertical: 10.sp,
            ),
          ),
        ),
      ),
    );
  }
  ScreenGroupRequests({
    required this.group,
    super.key});
}
