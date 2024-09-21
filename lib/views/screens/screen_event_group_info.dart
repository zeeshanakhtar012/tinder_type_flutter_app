import 'dart:developer';
import 'dart:ffi';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/views/screens/screen_create_group.dart';
import 'package:blaxity/views/screens/screen_group_chat.dart';
import 'package:blaxity/views/screens/screen_group_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/controller_get_groups.dart';
import '../../controllers/controller_home.dart';
import '../../models/group.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider_gradient.dart';

class ScreenEventGroupInfo extends StatelessWidget {
  Group group;
  GroupController groupController = Get.put(GroupController());

  ScreenEventGroupInfo({required this.group, super.key}) {
    // Call fetchGroup in the constructor or in the init state of a StatefulWidget if needed.
    groupController.fetchGroup(group.id!);
  }



  @override
  Widget build(BuildContext context) {
    log("MyId ${Get.find<ControllerHome>().user.value!.user.id}");
    bool isAdmin = group.members.any(
            (member) => member.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!) && member.isAdmin
    );

    String getButtonText(List<Member> members) {
      // Check if the user exists in the group
      if (members.isNotEmpty) {
        log(members.length.toString());

        bool userExists = members.any((member) =>
        member.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!)
        );

        if (userExists) {
          var user = members.firstWhere(
                  (member) => member.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!)
          );

          // User exists, now check join status and canJoin
          if ((user.canJoin && user.joinStatus == 1) || isAdmin) {  // Make sure joinStatus is an int
            return "Message";
          } else {
            return "Join Request Pending";
          }
        } else {
          return "Join";
        }
      } else {
        return "Join";
      }
    }


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Group Info"),
          actions: [
            if (isAdmin)
              IconButton(
                  onPressed: () {

                    Get.to(ScreenCreateGroup(group: group));
                  },
                  icon: Icon(
                    CupertinoIcons.pencil,
                    color: Colors.white,
                  ))
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body:RefreshIndicator(
          color: AppColors.appColor,
          onRefresh: () {
            groupController.fetchGroup(group.id!);
            return Future.value();
          },
          child: Obx(() {
            if (groupController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            else{
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * .3,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFF1d1d1d),
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${APiEndPoint.imageUrl + groupController.selectedGroup.value!.img}"))),
                    ),
                    Text(
                      "${groupController.selectedGroup.value!.title}",
                      style: AppFonts.titleLogin,
                    ).marginOnly(
                      top: 10.h,
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColors.buttonColor.createShader(bounds);
                          },
                          child: Icon(
                            Icons.filter,
                            // size: 10,
                          ),
                        ),
                        Text(
                          "Group",
                          style: AppFonts.subscriptionTitle,
                        ).marginOnly(
                          left: 5.sp,
                        ),
                      ],
                    ).marginSymmetric(
                      vertical: 5.h,
                    ),
                    Text(
                      "${groupController.selectedGroup.value!.title}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ).marginSymmetric(
                      vertical: 5.h,
                    ),
                    GradientDivider(
                      thickness: 0.2,
                      gradient: AppColors.buttonColor,
                      width: Get.width,
                    ).marginSymmetric(
                      vertical: 5.h,
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColors.buttonColor.createShader(bounds);
                          },
                          child: Icon(
                            Icons.person,
                            // size: 10,
                          ),
                        ),
                        Text(
                          "Admin",
                          style: AppFonts.subscriptionTitle,
                        ).marginOnly(
                          left: 5.sp,
                        ),
                      ],
                    ).marginOnly(
                      top: 15.h,
                    ),
                    Text(
                      "${groupController.selectedGroup.value!.owner}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                    GradientDivider(
                      thickness: 0.2,
                      gradient: AppColors.buttonColor,
                      width: Get.width,
                    ).marginSymmetric(
                      vertical: 5.h,
                    ),
                    // Row(
                    //   children: [
                    //     ShaderMask(
                    //       shaderCallback: (Rect bounds) {
                    //         return AppColors.buttonColor.createShader(bounds);
                    //       },
                    //       child: Icon(
                    //         Icons.location_on_outlined,
                    //         // size: 10,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Local Group",
                    //       style: AppFonts.subscriptionTitle,
                    //     ).marginOnly(
                    //       left: 5.sp,
                    //     ),
                    //   ],
                    // ).marginOnly(
                    //   top: 15.sp,
                    // ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "Beirut, London",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 12.sp,
                    //     ),
                    //   ),
                    // ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColors.buttonColor.createShader(bounds);
                          },
                          child: Icon(
                            Icons.groups,
                            // size: 10,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                           if (isAdmin) {
                             Get.to(ScreenGroupRequests(
                               group: groupController.selectedGroup.value!,
                             ));
                           }
                          },
                          child: Text(
                            "Members",
                            style: AppFonts.subscriptionTitle,
                          ).marginOnly(
                            left: 5.sp,
                          ),
                        ),
                      ],
                    ).marginOnly(
                      top: 15.sp,
                    ),
                    if (groupController.selectedGroup.value!.members.isNotEmpty)
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          groupController.selectedGroup.value!.members.length,
                              (index) {
                            Member member = groupController.selectedGroup.value!.members[index];
                            return member.user == null
                                ? Container()
                                : Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.only(right: 4.w),
                              decoration: BoxDecoration(
                                // gradient: AppColors.buttonColor,
                                border: Border.all(
                                  color: Color(0xFFA7713F),
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return AppColors.buttonColor
                                          .createShader(bounds);
                                    },
                                    child: (member.user!.userType == "couple")
                                        ? Icon(
                                      Icons.group,
                                      // size: 10,
                                    )
                                        : Icon(Icons.person),
                                  ),
                                  Text(
                                    member.user!.userType == "couple"
                                        ? (member.user!.partner1Name != null &&
                                        member.user!.partner1Name!
                                            .isNotEmpty &&
                                        member.user!.partner2Name !=
                                            null &&
                                        member.user!.partner2Name!
                                            .isNotEmpty)
                                        ? "${member.user!.partner1Name![0].toUpperCase()}&${member.user!.partner2Name![0].toUpperCase()}"
                                        : "No Partner Names"
                                        : (member.user!.fName != null &&
                                        member.user!.fName!.isNotEmpty)
                                        ? "${member.user!.fName![0].toUpperCase()}"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ).marginOnly(),
                    GradientDivider(
                      thickness: 0.2,
                      gradient: AppColors.buttonColor,
                      width: Get.width,
                    ).marginSymmetric(
                      vertical: 5.h,
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColors.buttonColor.createShader(bounds);
                          },
                          child: Icon(
                            Icons.message_outlined,
                            // size: 10,
                          ),
                        ),
                        Text(
                          "Description",
                          style: AppFonts.subscriptionTitle,
                        ).marginOnly(
                          left: 5.sp,
                        ),
                      ],
                    ).marginOnly(
                      top: 15.sp,
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        groupController.selectedGroup.value!.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GradientDivider(
                      thickness: 0.2,
                      gradient: AppColors.buttonColor,
                      width: Get.width,
                    ).marginSymmetric(
                      vertical: 5.h,
                    ),
                    CustomButton(
                      onTap: (){
                        String status=getButtonText(groupController.selectedGroup.value!.members);
                        if(status=="Join"){
                          groupController.joinGroup(groupController.selectedGroup.value!.id);

                        }else if(status=="Message"){
                          Get.to(ScreenGroupChat(group: groupController.selectedGroup.value!));
                          // groupController.leaveGroup(group.id);
                        }
                        else{
                          FirebaseUtils.showError("Please wait for group to be approved");
                        }

                      },
                      text: getButtonText(groupController.selectedGroup.value!.members),
                      textColor: Colors.white,
                      buttonGradient: AppColors.buttonColor,
                    ).marginOnly(
                      top: 20.h,
                    ),
                  ],
                ).marginSymmetric(
                  horizontal: 15.h,
                  vertical: 15.w,
                ),
              );
            }
          }),
        )
      ),
    );
  }

}
