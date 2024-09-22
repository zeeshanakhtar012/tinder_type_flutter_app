import 'dart:developer';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/firebase_utils.dart';
import 'package:blaxity/controllers/controller_event.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/event.dart';
import 'package:blaxity/views/screens/screen_individual/screen_create_event.dart';
import 'package:blaxity/views/screens/screen_view_organizer_profile.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../screens/screen_event_detail.dart';
import 'item_event/event_button/item_event.dart';

class ItemClubHomeEvent extends StatelessWidget {
  bool isMyEvent;

  Event event;
RxBool loading=false.obs;
  @override
  Widget build(BuildContext context) {
    bool isAttended = event.attendees?.any((attendee) => attendee.id == int.parse(Get.find<ControllerHome>().user.value!.user.id!)) ?? false;
    String statusText = 'Attend';

    if (isAttended) {
      Attendee? attendee = event.attendees?.firstWhere((attendee) => attendee.id ==int.parse( Get.find<ControllerHome>().user.value!.user.id!         ));
      if (attendee?.pivot?.actionStatus != null) {
        if (attendee!.pivot!.actionStatus == 'approved') {
          statusText = 'Attended';
        } else if (attendee.pivot!.actionStatus == 'pending') {
          statusText = 'Pending';
        }
      }
    }
    final height = MediaQuery
        .sizeOf(context)
        .height;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return GestureDetector(
      onTap: () {
        Get.to(ScreenEventDetails(event: event,));
      },
      child: SizedBox(
        height: 480.h,
        width: Get.width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                margin: EdgeInsets.only(bottom: 16.h,),
                width: width,
                // height: Get.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFA7713F),
                    ),
                    color: Color(0xFF1D1D1D)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/icon_eventSection_svg.svg",
                        ),
                        Text("Events", style: AppFonts.subscriptionTitle,)
                            .marginOnly(
                          left: 10.w,
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          "assets/icons/icon_share.svg",
                        ),
                      ],
                    ).marginOnly(top: 5.h, bottom: 10.h),
                    Container(
                      height: 151.h,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius
                            .circular(10.r)),
                        image: DecorationImage(image: NetworkImage(
                          event.image == null ? "" : APiEndPoint.imageUrl +
                              event.image!,), fit: BoxFit.cover),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              height: 30.h,
                              width: 104.w,
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  event.privacy!,
                                  style: AppFonts.subscriptionDuration,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 15.h,
                          width: 15.w,
                          "assets/icons/icon_event_name.svg",
                        ).marginSymmetric(
                            vertical: 5.h,
                            horizontal: 5.w
                        ),
                        GradientWidget(

                          child: Text(event.user!.fName?? "No User",
                            style: TextStyle(
                                fontSize: 14.sp

                            ),
                          ).marginOnly(
                            left: 5.w,
                          ),
                        ),

                      ],
                    ),
                    Text(
                        style: AppFonts.subscriptionDuration.copyWith(
                            color: Colors.white
                        ),
                        event.title!),
                    GradientWidget(child: Divider()),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/icon_location.svg"),
                        Expanded(
                          child: Text(
                              style: AppFonts.subtitle,
                              event.location?? "No Location").marginOnly(
                            left: 6.w,
                          ),
                        ),

                      ],
                    ).marginSymmetric(vertical: 3.h),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/icon_calneder.svg"),
                        Text(
                            style: AppFonts.subtitle,
                            event.date!
                        ).marginOnly(
                          left: 6.w,
                        )
                      ],
                    ).marginSymmetric(vertical: 3.h),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/icon_clock.svg"),
                        Text(
                            style: AppFonts.subtitle,
                            event.time!).marginOnly(
                          left: 5.w,
                        )
                      ],
                    ).marginSymmetric(vertical: 3.h),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/icons/icon_member.svg"),
                        Text(
                            style: AppFonts.subtitle,
                            "${event.attendeesCount ?? 0} members").marginOnly(
                          left: 6.w,
                        )
                      ],
                    ).marginSymmetric(vertical: 3.h),
                    if(event.pricing=="Paid")Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/icons/pay.svg"),
                        Text(
                            style: AppFonts.subtitle,
                            "${event.entrancePrice} \$").marginOnly(
                          left: 6.w,
                        )
                      ],
                    ).marginSymmetric(vertical: 3.h),
                     Obx(() {
                       return  (event.userId != int.parse(Get.find<ControllerHome>().user.value!.user.id!))?
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           SelectableButton(
                             text: 'Organizer', isSelected: false, onTap: () {
                             Get.to(ScreenViewOrganizerProfile(event.userId!));
                           },),
                           SizedBox(width: 10.w,),
                           Obx(() {


                             return SelectableButton(
                               loading: loading.value,
                               text: statusText,
                               isSelected: statusText == 'Attended',
                               onTap: () async {
                                 int reminderCount = event.attendeeLimit!-event.attendees!.length;
                                 log(reminderCount.toString());
                                 log("Attendee Limit:${event.attendeeLimit.toString()}");
                                 log("Attendee Count:${event.attendees!.length.toString()}");
                                 log("Attendee Length:${event.attendees!.length.toString()}");
                                if (Get.find<ControllerHome>().user.value!.user.userType=="couple"&&reminderCount<1) {
                                  FirebaseUtils.showError("You can not attend more than ${event.attendeeLimit} events");
                                }
                                else{
                                  loading.value = true;
                                  await  Get.find<EventController>().attendEvent(event.id!);
                                  await  Get.find<EventController>().fetchEvents();
                                  loading.value = true;
                                }
                               },
                             );
                           }),
                         ],).marginSymmetric(vertical: 10.h)
                           : Align(
                         alignment: Alignment.center,
                             child: IntrinsicWidth(
                               child: GradientWidget(
                                 child: SelectableButton(text: 'Edit',
                                   isSelected: false,
                                   onTap: () {
                                     Get.to(ScreenCreateEventIndividual(user: Get
                                         .find<ControllerHome>()
                                         .user
                                         .value!
                                         .user, event: event,));
                                   },).marginSymmetric(vertical: 10.h),
                               ),
                             ),
                           );
                     })

                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: SvgPicture.asset("assets/icons/circle_down.svg"),
            ),
            if(isMyEvent)Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SvgPicture.asset("assets/icons/flash.svg"),
            ),
          ],
        ),
      ).marginSymmetric(vertical: 6.h),
    );
  }

  ItemClubHomeEvent({
    required this.isMyEvent,
    required this.event,
  });
}
