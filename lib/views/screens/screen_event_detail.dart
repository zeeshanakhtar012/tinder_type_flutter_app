import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/constants/fonts.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/event_controllers/create_event_controller.dart';
import 'package:blaxity/models/event.dart';
import 'package:blaxity/views/home_page/home_page.dart';
import 'package:blaxity/views/screens/screen_events_request.dart';
import 'package:blaxity/views/screens/screen_individual/screen_create_event.dart';
import 'package:blaxity/views/screens/screen_userChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/controller_home.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_selectable_button.dart';

class ScreenEventDetails extends StatelessWidget {
  Event event;
  EventController eventController = Get.put(EventController());
  ControllerCreateEvent controllerCreateEvent = Get.put(
      ControllerCreateEvent());

  @override
  Widget build(BuildContext context) {
    log(event.id.toString());
    bool isAttended = event.attendees?.any((attendee) =>
    attendee.id == int.parse(Get
        .find<ControllerHome>()
        .user
        .value!
        .user
        .id!)) ?? false;
    String statusText = 'Attend';

    if (isAttended) {
      Attendee? attendee = event.attendees?.firstWhere((attendee) =>
      attendee.id == int.parse(Get
          .find<ControllerHome>()
          .user
          .value!
          .user
          .id!));
      if (attendee?.pivot?.actionStatus != null) {
        if (attendee!.pivot!.actionStatus == 'approved') {
          statusText = 'Attended';
        } else if (attendee.pivot!.actionStatus == 'pending') {
          statusText = 'Pending';
        }
      }
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            if (event.userId == Get
                .find<ControllerHome>()
                .user
                .value!
                .user
                .id!) Obx(() {
              return IconButton(
                onPressed: controllerCreateEvent.isLoading.value
                    ? null
                    : () async {
                  controllerCreateEvent.isLoading.value = true;

                  /// remaining admin condition to check if it is admin///
                  await controllerCreateEvent.deleteEvent(eventId: event.id!);
                  controllerCreateEvent.isLoading.value = false;
                },
                icon: controllerCreateEvent.isLoading.value
                    ? Container(
                  width: 24.w,
                  height: 24.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Color(0xFFA26837),
                    ),
                  ),
                )
                    : Icon(CupertinoIcons.delete, color: Colors.white),
              );
            }),
            if (event.userId == Get
                .find<ControllerHome>()
                .user
                .value!
                .user
                .id!) IconButton(onPressed: () {
              print("Event Id == ${event.id}");
              Get.to(ScreenCreateEventIndividual(user: Get
                  .find<ControllerHome>()
                  .user
                  .value!
                  .user, event: event));
            }, icon: Icon(CupertinoIcons.pencil, color: Colors.white,))
          ],
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * .3,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color(0xFF1D1D1D),
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: NetworkImage(
                            APiEndPoint.imageUrl + event.image!),
                        fit: BoxFit.cover
                    )
                ),),
              Text(event.title!, style: AppFonts.subscriptionBlaxityGold,)
                  .marginOnly(
                top: 20.h,
                left: 10.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      "assets/icons/icon_event_name.svg"),
                  Text("Event", style: AppFonts.subscriptionTitle,).marginOnly(
                    left: 8.sp,
                  ),
                ],
              ).marginOnly(
                top: 10.sp,
              ),
              Text(event.title!, style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),).marginOnly(
                top: 10.h,
                left: 10.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      "assets/icons/icon_event_owner.svg"),
                  Text("Owner", style: AppFonts.subscriptionTitle,).marginOnly(
                    left: 5.sp,
                  ),
                ],
              ).marginOnly(
                top: 15.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(event.user!.fName!, style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),).marginOnly(
                  top: 10.h,
                  left: 10.w,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      "assets/icons/icon_loaction_event.svg"),
                  Text("Local Group", style: AppFonts.subscriptionTitle,)
                      .marginOnly(
                      left: 10.w
                  ),
                ],
              ).marginOnly(
                top: 15.sp,
              ),
              Text(event.location!, style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),).marginOnly(
                top: 10.h,
                left: 10.w,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      "assets/icons/icon_event_attendees.svg"),
                  InkWell(
                    onTap: () {
                      if (event.userId==int.parse(Get.find<ControllerHome>().user.value!.user.id!)) {
                        Get.to(ScreenEventsRequests(event: event,));
                      }
                    },
                    child: Text("Attendees", style: AppFonts.subscriptionTitle,)
                        .marginOnly(
                      left: 5.sp,
                    ),
                  ),
                ],
              ).marginOnly(
                top: 15.sp,
              ),
              Wrap(
                children: List.generate(event.attendees!.length, (index) =>
                    GestureDetector(
                      onTap: () {
                        // Get.to(ScreenUserChat(id: event.attendees![index].id!));
                      },
                      child: Container(
                        height: 39.33.h,
                        width: 39.33.w,
                        margin: EdgeInsets.only(right: 3.w),
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          // gradient: AppColors.buttonColor,
                          border: Border.all(
                            width: 2.w,
                            color: Color(0xFFA7713F),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return AppColors.buttonColor.createShader(
                                    bounds);
                              },
                              child: event.attendees![index].userType ==
                                  "couple" ? Icon(
                                Icons.group,
                                size: 15.h,
                              ) : Icon(
                                Icons.person,
                                size: 15.h,
                              ),
                            ),
                            Text(event.attendees![index].userType == "couple"
                                ? "${event.attendees![index].partner1Name![0]
                                .toUpperCase()}&${event.attendees![index]
                                .partner2Name![0].toUpperCase()}"
                                : event.attendees![index].fName![0]
                                .toUpperCase(), style: TextStyle(
                              fontSize: 6.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),),).marginOnly(
                top: 10.h,
                left: 10.w,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/icons/icon_event_description.svg"),
                  Text("Description", style: AppFonts.subscriptionTitle,)
                      .marginOnly(
                    left: 5.sp,
                  ),
                ],
              ).marginOnly(
                top: 15.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  event.description ?? "", style: TextStyle(fontSize: 12.sp,
                  color: Colors.white,
                ),),
              ).marginOnly(
                top: 10.h,
                left: 10.w,
              ),
              (event.userId == int.parse(FirebaseUtils.myId)) ? SizedBox() : Obx(() {
                return CustomButton(
                  loading: eventController.isLoading.value,
                  text: statusText,
                  onTap: () {
                    if (statusText != "Pending" || statusText != "Rejected" ||
                        statusText != "Attended") {}
                    else {
                      eventController.attendEvent(event.id!);
                    }
                  },
                  textColor: Colors.white,
                  buttonGradient: AppColors.buttonColor,
                );
              }).marginSymmetric(
                vertical: 13.h,
              ),
              if (event.userId == int.parse(Get.find<ControllerHome>().user.value!.user.id!))CustomSelectbaleButton(
                imageUrl: 'assets/icons/icon_flash_png.png',
                isSelected: true,
                gradient: AppColors.buttonColor,
                titleButton: "Boost",
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Get.to(ScreenBeSeenDetails());
                },
                width: Get.width * .9,
                height: 52.h,
                strokeWidth: 4,
              ).marginSymmetric(vertical: 33.h),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }

  ScreenEventDetails({
    required this.event,
  });
}