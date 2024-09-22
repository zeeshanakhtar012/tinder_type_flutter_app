import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/last_message.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_userChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:blaxity/constants/colors.dart';

import '../../controllers/controller_personal_chat.dart';

class ItemGroupChatList extends StatelessWidget {
  final LastMessage lastMessage;

  ItemGroupChatList({
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Create a separate controller for each chat item
    final ItemGroupChatController controller = Get.put(ItemGroupChatController(), tag: lastMessage.chatRoomId);

    List<String> membersId = lastMessage.membersId.where((e) => e != FirebaseUtils.myId).toList();
    List<int> las = membersId.map((e) => int.parse(e)).toList();

    return FutureBuilder<List<User>>(
      future: Get.find<ControllerHome>().fetchUsersByIds(las),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            heightFactor: 2.h,
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text("Internet Error");
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text("No Users Found");
        }
String userName="";
        List<User> users = snapshot.data ?? [];
        if (users.isNotEmpty) {
          // Build user name string logic
          userName = users[0].userType == "couple"
              ? "${users[0].partner1Name}&${users[0].partner2Name}"
              : users[0].fName ?? "";
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FadeTransition(
                    opacity: controller.animation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            _showBottomSheet(users[0], context, lastMessage);
                          },
                          child: Container(
                            height: 75.h,
                            width: 54.w,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Details",
                                  style: TextStyle(color: Colors.white),
                                ).marginOnly(
                                  top: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 75.h,
                          width: 54.w,
                          decoration: BoxDecoration(
                            gradient: AppColors.buttonColor,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 5.h,
                                right: 10.0.w,
                                child: Container(
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.buttonColor,
                                  ),
                                  child: Center(
                                    child: Text("4"),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.archive,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  log("Archive button is tapped");
                                },
                              ),
                              Positioned(
                                bottom: 5.w,
                                right: 0,
                                left: 0,
                                child: Text(
                                  "Archive",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  ScreenUserChat(
                    usersList: users,
                    chatRoomId: lastMessage.chatRoomId,
                    counter: lastMessage.counter,
                    userType:"couple",
                    lstMsg: lastMessage,
                  ),
                );
              },
              onHorizontalDragUpdate: controller.handleSwipeUpdate,
              onHorizontalDragEnd: controller.handleSwipeEnd,
              child: Obx(
                    () => Transform.translate(
                  offset: Offset(-controller.swipeOffset.value, 0),
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.white.withOpacity(0.5),
                        height: 0.01,
                      ),
                      ListTile(
                        title: Text(
                          userName,
                          style: TextStyle(
                            fontSize: 13.24.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          lastMessage.lastMessage,
                          style: TextStyle(
                            fontSize: 8.24.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(FirebaseUtils.myImage),
                        ),
                        trailing: controller.isSwiped.value
                            ? SizedBox.shrink()
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              FirebaseUtils.convertMillisToTimeString(lastMessage.timestamp),
                              style: TextStyle(
                                fontSize: 10.24.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            if (lastMessage.counter != 0)
                              Container(
                                height: 20.h,
                                width: 20.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.buttonColor,
                                ),
                                child: Center(
                                  child: Text(lastMessage.counter.toString()),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ).marginSymmetric(vertical: 8.h);
      },
    );
  }

  void _showBottomSheet(User user, BuildContext context,LastMessage lastMessage) {
    Get.bottomSheet(
      Container(
        height: 300.h,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.fName ?? "No User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/icons/icon_cross.svg"),
                ),
              ],
            ).marginOnly(
              left: 10.w,
              right: 10.w,
              bottom: 15.h,
            ),
            // _bottomSheetRow(
            //   context,
            //   title: "Mute",
            //   iconPath: "assets/icons/icon_mute.svg",
            // ),
            Divider(thickness: 0.3.h),
            _bottomSheetRow(
              context,
              title: "Clear Chat",
              iconPath: "assets/icons/icon_clear_chat.svg", onTap: () {
              Get.find<ControllerPersonalChat>().clearChatForUser(lastMessage.chatRoomId);
              Navigator.pop(context);
            },
            ),
            Divider(thickness: 0.3.h),
            _bottomSheetRow(
              context,
              title: "Block ${user.fName ?? 'No User'}",
              iconPath: "assets/icons/icon_block.svg",
              titleColor: Colors.red, onTap: () {
              Get.find<ControllerHome>().blockUser(blockedUserId: user.id!.toString());
              Navigator.pop(context);

            },
            ),
            Divider(thickness: 0.3.h),
            _bottomSheetRow(
              context,
              title: "Delete Chat",
              iconPath: "assets/icons/icon_delete_chat.svg",
              titleColor: Colors.red, onTap: () {
              FirebaseFirestore.instance.collection("user").doc(FirebaseUtils.myId).collection("chats").doc(lastMessage.chatRoomId).delete();
              Navigator.pop(context);
            },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _bottomSheetRow(
      BuildContext context, {
        required String title,
        required String iconPath,
        required VoidCallback onTap,
        Color titleColor = Colors.white,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SvgPicture.asset(iconPath),
        ],
      ).marginOnly(
        top: 5.h,
        left: 10.w,
        right: 10.w,
      ),
    );
  }}

class ItemGroupChatController extends GetxController with GetSingleTickerProviderStateMixin {
  RxBool isSwiped = false.obs;
  RxDouble swipeOffset = 0.0.obs;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  void handleSwipeUpdate(DragUpdateDetails details) {
    swipeOffset.value -= details.primaryDelta!;
    if (swipeOffset.value > 100) {
      swipeOffset.value = 100; // Limit swipe distance
    } else if (swipeOffset.value < 0) {
      swipeOffset.value = 0; // Prevent over-swiping in the opposite direction
    }
  }

  void handleSwipeEnd(DragEndDetails details) {
    if (swipeOffset.value >= 50) {
      isSwiped.value = true;
      animationController.forward();
    } else {
      swipeOffset.value = 0;
      animationController.reverse();
    }
  }
}