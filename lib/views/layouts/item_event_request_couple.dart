import 'dart:developer';

import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/controller_get_couple_sphere.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/event.dart';
import 'package:blaxity/models/event_request.dart';
import 'package:blaxity/views/screens/screen_userChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/controller_get_couple.dart';
import '../../models/user.dart';
import 'item_event/event_button/item_event.dart';

class ItemEventCouple extends StatelessWidget {
  EventRequest eventRequest;
  Event event;
  EventController eventController = Get.put(EventController());
  CoupleController coupleController = Get.put(CoupleController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 48.59.h,
              width: 48.59.w,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                // gradient: AppColors.buttonColor,
                border: Border.all(
                  width: 4.w,
                  color: Color(0xFFA7713F),
                ),
                shape: BoxShape.circle,
              ),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return AppColors.buttonColor.createShader(bounds);
                    },
                    child: Icon(
                      Icons.group,
                      // size: 15.h,
                    ),
                  ),
                  Text("S&R", style: TextStyle(
                    fontSize: 6.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2 min ago",
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Text(eventRequest.userType=="couple"?"${eventRequest.partner1Name} & ${eventRequest.partner2Name}":"${eventRequest.fName}", style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),),
                    Icon(
                      size: 8.sp,
                      CupertinoIcons.location_solid,
                      color: Color(0xFFA7713F),).marginOnly(
                      left: 5.sp,
                    ),
                    Text("2 km",
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text("Requested to join your event"),
              ],
            ).marginOnly(
              left: 6.sp,
            ),
            Spacer(),
            IconButton(onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios,
                  color: Colors.white,))
          ],
        ).marginOnly(
          top: 20.sp,
        ),
        (eventRequest.pivot!.actionStatus=="pending")?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return SelectableButton(
                loading: eventController.isAccepting.value,
                text: 'Accept',
                isSelected: false,
                onTap: () {
                  eventController.acceptEventRequest(
                      event.id!, eventRequest.id);
                },
              );
            }),
            Obx(() {
              return SelectableButton(
                loading: eventController.isRejecting.value,

                text: 'Decline',
                isSelected: false,
                onTap: () {
                  eventController.rejectEventRequest(
                      event.id!, eventRequest.id);
                },
              );
            }).marginOnly(
              left: 15.sp,
            ),
            SelectableButton(
              text: 'Message',
              isSelected: false,
              onTap: () async {
                if (eventRequest.userType ==
                    "couple") {

                  await coupleController.fetchCoupleDetails(eventRequest
                      .coupleId.toString())
                      .then((userCouple) async {
                    List<User> userList = userCouple.data;
                    if (userList.length > 1) {
                      User currentUser = Get
                          .find<ControllerHome>()
                          .user
                          .value!
                          .user;
                      if (currentUser.userType == "couple") {
                        await coupleController.fetchCoupleDetails(
                            currentUser.coupleId.toString()).then((
                            myCouple) {
                          userList =
                              myCouple.data.where((e) => e.id != currentUser.id)
                                  .toList();
                          Get.to(ScreenUserChat(usersList: userList));
                        });
                      } else {
                        Get.to(ScreenUserChat(usersList: userList));
                      }
                    } else {
                      FirebaseUtils.showError(
                          "Your partner is not available");
                    }
                  });
                } else {
                  ControllerHome controllerHome = Get.find<ControllerHome>();
                  await controllerHome.fetchUserByIdProfile(eventRequest.id).then((value){
                    Get.to(ScreenUserChat(usersList: [value.user],));
                  });

                }
              },
            ).marginOnly(
              left: 15.sp,
            ),
          ],
        ).marginOnly(
          top: 20.sp,
        ):SelectableButton(
    text: 'Message',
    isSelected: false,
    onTap: () {
      log("message tapped");
    },
    ),
        // Add other content here
      ],
    );
  }

  ItemEventCouple({
    required this.eventRequest,
    required this.event,
  });
}
