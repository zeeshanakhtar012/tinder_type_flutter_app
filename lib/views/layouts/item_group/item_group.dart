import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/controller_get_groups.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/models/group.dart';
import 'package:blaxity/views/screens/screen_event_group_info.dart';
import 'package:blaxity/views/screens/screen_group_chat.dart';
import 'package:blaxity/widgets/custom_divider_gradient.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_home.dart';
import '../../../widgets/custom_button.dart';
import '../item_event/event_button/item_event.dart';

class ItemGroup extends StatelessWidget {
  Group group;
        RxBool isJoined = false.obs;
        GroupController groupController = Get.put(GroupController());
  @override
  Widget build(BuildContext context) {
    bool isAdmin = group.members.any(
            (member) => member.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!) && member.isAdmin);

    RxBool     _isJoined = group.members.any((member) => member.userId == Get.find<ControllerHome>().user.value!.user.id!).obs;
    String getButtonText(List<Member> members) {
      // Check if the user exists in the group
      if (members != null && members.isNotEmpty) {
        log(members.length.toString());

        bool userExists = members.any((member) => member.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!));

        if (userExists) {
          var user = members.firstWhere(
                (member) => member.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!),
          );

          // User exists in the group, now check the join status and canJoin
          if (user.canJoin == true && user.joinStatus == "1"||isAdmin) {
            return "Message";
          } else {
            return "Request Pending";
          }
        } else {
          // User is not in the group
          return "Join";
        }
      } else {
        // Members list is null or empty
        return "Join";
      }
    }

    return InkWell(
      onTap: (){
        Get.to(ScreenEventGroupInfo(group: group,));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),

        margin: EdgeInsets.symmetric(vertical: 10.w),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff1D1D1D),
         
          border: Border.all(
            color:Color(0xFFA26837)
          )

        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 164.h,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff353535),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(APiEndPoint.imageUrl + group.img!),
                  )),
            ),
            Text(
              group.title!,
              style: AppFonts.subscriptionTitle.copyWith(fontSize: 20.sp,
                fontWeight: FontWeight.bold
              ),
            ).marginOnly(top: 12.h),
            Text(
              group.description,
              style: TextStyle(
                color: Color(0xFFD0D0D0),
                fontSize: 13.sp,
              ),
            ).marginSymmetric(vertical: 6.h),
            GradientDivider(gradient:AppColors.buttonColor , width: Get.width*.8,).marginSymmetric(vertical: 4
                .h),
            Row(
              children: [
                SvgPicture.asset("assets/icons/icon_group.svg"),
                Text(
                  "${group.members.length} Members",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ).marginOnly(
                  left: 3.sp,
                )
              ],
            ).marginSymmetric(vertical: 4.h),
            Row(
              children: [
                SvgPicture.asset("assets/icons/privacy.svg"),
                Text(
                  group.isPrivate ? "Private" : "Public",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ).marginOnly(
                  left: 3.sp,
                )
              ],
            ).marginSymmetric(vertical: 4.h),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SelectableButton(text: 'Info', isSelected: false, onTap: () { 
                Get.to(ScreenEventGroupInfo(group: group));
              },
                
              ),
              SizedBox(width: 10.w),

              Obx(() {
                return SelectableButton(
                  loading: isJoined.value,
                  text: getButtonText(group.members),
                  onTap: () async {
                   if (getButtonText(group.members)=="Message") {
                     Get.to(ScreenGroupChat(group: group));
                   }
                   else if(getButtonText(group.members)=="Request Pending"){
                     FirebaseUtils.showError( "Please wait for Request Pending");
                   }
                   else{
                     isJoined.value = true;
                     await groupController.joinGroup(group.id);
                     isJoined.value = false;
                   }
                  }, isSelected: true,
                );
              }),

            ],).marginSymmetric(vertical: 12.h),
          ],
        ),
      ),
    );
  }

  ItemGroup({
    required this.group,
  });
}
