import 'package:blaxity/constants/extensions/time_ago.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/views/screens/screen_view_connections.dart';
import 'package:blaxity/views/screens/screen_view_description.dart';
import 'package:blaxity/views/screens/screen_view_events.dart';
import 'package:blaxity/views/screens/screen_view_user_photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/ApiEndPoint.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_selectable_button.dart';
import '../layouts/item_event_profile.dart';

class ScreenViewOrganizerProfile extends StatelessWidget {
  int id;

  ScreenViewOrganizerProfile(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
        ),
        body: FutureBuilder<UserResponse>(
          future: Get.find<ControllerHome>().fetchUserByIdProfile(id),
          builder:
              (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            User user = snapshot.data!.user!;
            Get.find<ControllerHome>().viewUserCount(int.parse(user!.id!));

            Club club = user.clubs!.first;
            String image = APiEndPoint.imageUrl +
                (club != null ? club.logo ?? "https://via.placeholder.com/250" : user.profile ?? "https://via.placeholder.com/250");
            List<String> imagesList=user.userType=="club_event_organizer"?user.clubs!.first.recentImages!.map((e) => APiEndPoint.imageUrl+e).toList():user.singleRecentImage!.userRecentImages!.map((e) => APiEndPoint.imageUrl+e).toList();

            return RefreshIndicator(
              color: AppColors.appColor,
              onRefresh: () {
                return
                Get.find<ControllerHome>().fetchUserByIdProfile(id);
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                        height: 83.h,
                        width: 83.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Color(0xFFA7713F), width: 1.5),
                            image: DecorationImage(
                              image: NetworkImage(image),
                            )),
                      ),
                    ),
                    Container(
                      height: 58.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFA7713F),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GradientText(
                            text: '${user.fName}',
                            style: AppFonts.homeScreenText,
                            gradient: AppColors.buttonColor,
                          ),
                          (user.isSubscribed == "1")
                              ? SvgPicture.asset(
                                  "assets/icons/icon_dimond.svg",
                                ).marginOnly(
                                  left: 8.sp,
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 194.w,
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                            gradient: AppColors.buttonColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.r),
                              bottomRight: Radius.circular(20.r),
                            )),
                        child: Center(
                          child: Text(
                            user.pmType?? "No",
                            style: AppFonts.subtitle,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFA7713F),
                                  )),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text((user.scores?? 0).toString()),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 20.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          gradient: AppColors.buttonColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10))),
                                      child: Center(
                                        child: Text("Level 0"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text("Score"),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFA7713F),
                                  )),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(getDaysSinceFromDateString(user.createdAt!).toString()),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 20.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                          gradient: AppColors.buttonColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10))),
                                      child: Center(
                                        child: Text("Year 0"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text("Days"),
                          ],
                        ).marginSymmetric(
                          horizontal: 20.sp,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: user.verified == 1
                                      ? AppColors.buttonColor
                                      : null,
                                  border: Border.all(
                                    color: Color(0xFFA7713F),
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text("Verified"),
                          ],
                        ),
                      ],
                    ).marginSymmetric(vertical: 6.h),
                  Obx((){
                    return (Get.find<ControllerHome>().user.value!.user.goldenMember == "1") ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      GradientText(
                        text: 'Photos',
                        style: AppFonts.homeScreenText,
                        gradient: AppColors.buttonColor,
                      ).marginSymmetric(vertical: 6.h),
                      (imagesList.isEmpty)?Text("No Images"): GestureDetector(
                        onTap: (){
                          Get.to(ScreenViewUserPhotos(imagesList: imagesList, UserName: user.fName!));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      imagesList.length,
                                          (index) => Container(
                                        width: 97.w,
                                        height: 152.h,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF353535),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            border: Border.all(
                                              width: 2.w,
                                              color: Color(0xFFA7713F),
                                            ),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    imagesList[index]))),)
                                          .marginOnly(right: 6.w),
                                    ),
                                  ),
                                )),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 24,
                            ),
                          ],
                        ).marginSymmetric(vertical: 6.h),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      GradientText(
                        text: 'Connections',
                        style: AppFonts.homeScreenText,
                        gradient: AppColors.buttonColor,
                      ).marginSymmetric(vertical: 6.h),
                      GestureDetector(
                        onTap: (){
                          Get.to(ScreenViewConnections(connections: snapshot.data!.Connections!, name: user.fName!,));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: (snapshot.data!.Connections != null)
                                  ? SingleChildScrollView(
                                child: Row(
                                  children: List.generate(
                                      snapshot.data!.Connections!.length>3?3:snapshot.data!.Connections!.length,
                                          (index) {
                                        User _user =
                                        snapshot.data!.Connections![index];
                                        return Container(
                                          height: 39.33.h,
                                          width: 39.33.w,
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
                                                  return AppColors.buttonColor
                                                      .createShader(bounds);
                                                },
                                                child: (_user.userType == "couple")
                                                    ? Icon(
                                                  Icons.group,
                                                  size: 15.h,
                                                )
                                                    : Icon(
                                                  Icons.person,
                                                  size: 15.h,
                                                ),
                                              ),
                                              Text(
                                                "${_user.userType == "couple" ? "${_user.partner1Name![0].toUpperCase()}${_user.partner1Name!.substring(1)}" : "${_user.fName![0].toUpperCase()}"}",
                                                style: TextStyle(
                                                  fontSize: 6.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              )
                                  : Text("No Connections"),
                            ),
                            if (snapshot.data!.Connections != null&&snapshot.data!.Connections!.isNotEmpty)
                              GradientText(
                                text: '+ ${snapshot.data!.Connections!.length}',
                                style: AppFonts.homeScreenText,
                                gradient: AppColors.buttonColor,
                              ).marginSymmetric(
                                horizontal: 6.w,
                              ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 24,
                            ),
                          ],
                        ).marginSymmetric(vertical: 6.h),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      GradientText(
                        text: 'Events',
                        style: AppFonts.homeScreenText,
                        gradient: AppColors.buttonColor,
                      ).marginSymmetric(vertical: 6.h),
                      if (user.eventsAction != null)
                        GestureDetector(
                          onTap: (){
                            Get.to(ScreenViewEvents(eventActions: user.eventsAction!));
                          },
                          child: Row(
                            children: [
                              Row(
                                children: List.generate(
                                  user.eventsAction!.length > 2
                                      ? 2
                                      : user.eventsAction!.length,
                                      (index) {
                                    return ItemUserEventProfile(
                                      event: user.eventsAction![index],
                                    );
                                  },
                                ),
                              ),
                              if (user.eventsAction!.length >= 3)
                                GradientText(
                                  text: '+ ${user.eventsAction!.length}',
                                  style: TextStyle(fontSize: 16.sp),
                                  gradient: AppColors.buttonColor,
                                ).marginSymmetric(
                                  horizontal: 6.sp,
                                ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 24,
                              ),
                            ],
                          ).marginSymmetric(vertical: 6.h),
                        ),
                      Divider(
                        color: Colors.white,
                      ),
                      GradientText(
                        text: 'About',
                        style: AppFonts.homeScreenText,
                        gradient: AppColors.buttonColor,
                      ).marginSymmetric(vertical: 6.h),
                      GestureDetector(
                        onTap: (){
                          Get.to(ScreenViewDescription(description:user.reference == null
                              ? ""
                              : user.reference!.description ?? "No Description"));
                        },
                        child: Row(
                          children: [
                            Text(
                              user.reference == null
                                  ? ""
                                  : user.reference!.description ?? "No Description",
                              style: AppFonts.homeScreenText,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 24,
                            ),
                          ],
                        ).marginSymmetric(vertical: 6.h),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                    ],):  Container(
                      height: 184.h,
                      width: 335.w,
                      margin: EdgeInsets.symmetric(vertical: 12.h),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xff1D1D1D),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFA7713F)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upgrade to Gold",
                            style: AppFonts.titleSuccessFullPassword,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Subscribe ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Color(0xffD0D0D0),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: "Blaxity Gold ",
                                  style: TextStyle(
                                    color: Color(0xFFA26837),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                  "to view full profiles\nand much more.",
                                  style: TextStyle(
                                    color: Color(0xffD0D0D0),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ).marginSymmetric(vertical: 6.h),
                          InkWell(
                            onTap: () {
                              Get.to(ScreenSubscription(isHome: true,));
                            },
                            child: Container(
                              height: 42.27.h,
                              width: 262.22.w,
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonColor,
                                borderRadius:
                                BorderRadius.circular(15.66.r),
                              ),
                              child: Center(
                                child: Text(
                                  "View subscription plans",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.66.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ).paddingOnly(top: 15.h),
                          ).marginSymmetric(vertical: 10.h),
                        ],
                      ),
                    );
                  })

                  ],
                ),
              ).marginSymmetric(horizontal: 20.w),
            );
          },
        ));
  }
}
