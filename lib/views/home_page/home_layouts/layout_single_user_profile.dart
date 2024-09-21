import 'package:blaxity/constants/extensions/time_ago.dart';
import 'package:blaxity/views/screens/screen_be_seen_details.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/views/screens/screen_view_connections.dart';
import 'package:blaxity/views/screens/screen_view_events.dart';
import 'package:blaxity/views/screens/screen_view_user_photos.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_blaxiter_subscription_single_user.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:ui';

import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/controllers/authentication_controllers/controller_sign_in_.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_event_edit_profile.dart';
import 'package:blaxity/views/screens/screen_start_verification.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../../constants/ApiEndPoint.dart';
import '../../../constants/firebase_utils.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_like_user.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../layouts/item_event_profile.dart';
import '../../layouts/item_profile_details.dart';
import '../../screen_test.dart';
import '../../screens/screen_advance_filter.dart';
import '../../screens/screen_match_person_profile.dart';
import '../../screens/screen_edit_profile.dart';
import '../../screens/screen_subscription_type_profile.dart';
import '../../screens/screen_userChat.dart';
import '../../screens/screen_view_description.dart';

class LayoutSingleUserProfile extends StatefulWidget {
  String id;
  bool? isMatch;

  @override
  State<LayoutSingleUserProfile> createState() =>
      _LayoutSingleUserProfileState();

  LayoutSingleUserProfile({required this.id, this.isMatch = false});
}

class _LayoutSingleUserProfileState extends State<LayoutSingleUserProfile> {
  int _selectedButtonIndex = -1;

  // void _onAvatarTap(int index) {
  //   setState(() {
  //     _selectedButtonIndex = index;
  //     if (_selectedButtonIndex == 3) Get.to(ScreenMatchPersonProfile());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // log(user);
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: (widget.isMatch == true)
          ? AppBar(
              centerTitle: true,
              title: Text(
                "Profile",
                style: TextStyle(color: Color(0xFFA7713F), fontSize: 20.sp),
              ),
            )
          : null,
      body: FutureBuilder<UserResponse>(
          future: Get.find<ControllerHome>()
              .fetchUserByIdProfile(int.parse(widget.id)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0xFFA7713F),
              ));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Low Internet Connection'));
            }
            UserResponse userResponse = snapshot.data!;
            User user = userResponse.user;
            log(user.id.toString());
            if (widget.isMatch==true) {
              Get.find<ControllerHome>().viewUserCount(int.parse(user!.id!));
            }

            return RefreshIndicator(
              color: Color(0xFFA7713F),
              onRefresh: () {
                return Get.find<ControllerHome>()
                    .fetchUserByIdProfile(int.parse(widget.id!));
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 83.h,
                      width: 83.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2.w,
                            color: Color(0xFFA7713F),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "${APiEndPoint.imageUrl}${user.singleRecentImage != null ? user.singleRecentImage!.userRecentImages!.first! : "https://via.placeholder.com/250"}"))),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return AppColors.buttonColor.createShader(bounds);
                        },
                      ),
                    ),
                    Container(
                      height: 65.h,
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
                            text: user.fName ?? "No User",
                            style: AppFonts.homeScreenText,
                            gradient: AppColors.buttonColor,
                          ),
                          SvgPicture.asset(
                            "assets/icons/icon_dimond.svg",
                          ).marginOnly(
                            left: 8.sp,
                          ),
                        ],
                      ),
                    ).marginOnly(top: 15.h),
                    Container(
                      width: 194.w,
                      decoration: BoxDecoration(
                          gradient: AppColors.buttonColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Center(
                        child: Text(
                          "${user.pmType ?? "No"} ",
                          style: AppFonts.subtitle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height * .15,
                          width: width * .15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFFA7713F),
                              )),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${user.scores ?? 0}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20.0.h,
                                left: 2.w,
                                child: Container(
                                  height: 20.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      gradient: AppColors.buttonColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Level 0",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Score",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(
                          horizontal: 10.sp,
                        ),
                        Container(
                          height: height * .15,
                          width: width * .15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFFA7713F),
                              )),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${getDaysSinceFromDateString(user.createdAt!)}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 18.0.sp,
                                left: 2.sp,
                                child: Container(
                                  height: 20.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      gradient: AppColors.buttonColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Year 0",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "Days",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(
                          horizontal: 10.sp,
                        ),
                        Container(
                          height: height * .15,
                          width: width * .15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: user.verified == 1
                                  ? Color(0xFFA7713F)
                                  : Colors.transparent,
                              border: Border.all(
                                color: Color(0xFFA7713F),
                              )),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  user.verified == 1 ? Icons.done : Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  user.verified == 1
                                      ? "Verified"
                                      : "Not Verified",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(
                          horizontal: 15.w,
                        ),
                      ],
                    ),
                    if(user!.verification!.status=="pending"&&widget.isMatch==false)Container(
                      height:184.h,
                      width: 335.w,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Color(0xff1D1D1D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFA7713F),
                          )
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset("assets/icons/icon_right_tick.svg")
                              .marginOnly(
                            top: 10.sp,
                            bottom: 10.sp,
                          ),
                          Text("Verify Your Profile",
                            style: AppFonts.titleSuccessFullPassword,),
                          Text(
                              textAlign: TextAlign.center,
                              style: AppFonts.subtitle,
                              "Enhance your credibility by verifying\nyour profile.")
                              .marginSymmetric(
                            vertical: 8.sp,
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(ScreenVerification());

                              if (user.verification!.status=="pending"&&user.verification!.selfie==null) {

                                Get.to(ScreenVerification());
                              }  else{
                                FirebaseUtils.showError("Your profile in Pending for Verification");
                              }
                            },
                            child: Container(
                              height: 31.3.h,
                              width: 194.19.w,
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(11.59.r),
                              ),
                              child: Center(
                                child: Text(
                                   user.verification!.status=="pending"&&user.verification!.selfie==null?"Start Verification":"Pending", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.66.sp,
                                  fontWeight: FontWeight.w700,
                                ),),
                              ),
                            ).paddingOnly(
                              top: 5.h,
                            ),
                          ),
                        ],
                      ),
                    ).marginOnly(
                      top: 30.sp,
                    ),
                    Obx(() {
                      final currentUser = Get.find<ControllerHome>().user.value!.user;

                      // Check if match is false or if the user is a golden member
                      if (widget.isMatch == false || Get.find<ControllerHome>().user.value!.user.goldenMember != 0) {
                        // Show all content (no need to check the plan)
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              text: 'Photos',
                              style: AppFonts.homeScreenText,
                              gradient: AppColors.buttonColor,
                            ).marginSymmetric(vertical: 15.sp),
                            if (user.singleRecentImage != null)
                              GestureDetector(
                                onTap: () {
                                  List<String> imagesList = user
                                      .singleRecentImage!.userRecentImages!
                                      .map((e) => APiEndPoint.imageUrl + e)
                                      .toList();
                                  Get.to(ScreenViewUserPhotos(
                                    imagesList: imagesList,
                                    UserName: user.fName!,
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                            user.singleRecentImage!
                                                .userRecentImages!.length>3?3:user.singleRecentImage!.userRecentImages!.length,
                                            (index) => Container(
                                              width: 97.w,
                                              height: 152.h,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF353535),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 2.w,
                                                    color: Color(0xFFA7713F)),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    APiEndPoint.imageUrl +
                                                        user.singleRecentImage!
                                                                .userRecentImages![
                                                            index],
                                                  ),
                                                ),
                                              ),
                                            ).marginOnly(right: 6.w),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 24,
                                    ),
                                  ],
                                ).marginSymmetric(vertical: 6.h),
                              ),
                            GradientText(
                              text: 'Connections',
                              style: AppFonts.homeScreenText,
                              gradient: AppColors.buttonColor,
                            ).marginOnly(top: 15.h),
                            GestureDetector(
                              onTap: () {
                                Get.to(ScreenViewConnections(
                                    connections: snapshot.data!.Connections!, name: user.fName!,));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: (snapshot
                                            .data!.Connections!.isNotEmpty)
                                        ? SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                  snapshot.data!.Connections!
                                                      .length>3?3:snapshot.data!.Connections!.length, (index) {
                                                User _user = snapshot
                                                    .data!.Connections![index];
                                                return Container(
                                                  height: 39.33.h,
                                                  width: 39.33.w,
                                                  margin: EdgeInsets.only(
                                                      right: 5.w,bottom: 8.h),
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
                                                        shaderCallback:
                                                            (Rect bounds) {
                                                          return AppColors
                                                              .buttonColor
                                                              .createShader(
                                                                  bounds);
                                                        },
                                                        child: (_user
                                                                    .userType ==
                                                                "couple")
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
                                                        "${_user.userType == "couple" ? "${_user.partner1Name![0].toUpperCase()}${_user.partner1Name!.substring(1)}" : "${_user.fName == null ? "" : _user.fName![0].toUpperCase()}"}",
                                                        style: TextStyle(
                                                          fontSize: 6.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                  if (snapshot.data!.Connections != null &&
                                      snapshot.data!.Connections!.isNotEmpty)
                                    GradientText(
                                      text:
                                          '+ ${snapshot.data!.Connections!.length}',
                                      style: AppFonts.homeScreenText,
                                      gradient: AppColors.buttonColor,
                                    ).marginSymmetric(
                                      horizontal: 6.sp,
                                    ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ],
                              ).marginSymmetric(vertical: 5.h),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 0.5,
                              height: 0,
                            ),
                            GradientText(
                              text: 'Events',
                              style: AppFonts.homeScreenText,
                              gradient: AppColors.buttonColor,
                            ).marginOnly(top: 15.h),
                            if (user.eventsAction != null)
                              GestureDetector(
                                onTap: () {
                                  Get.to(ScreenViewEvents(
                                      eventActions: user.eventsAction!));
                                },
                                child: Row(
                                  children: [
                                    (user.eventsAction != null&&user.eventsAction!.isNotEmpty)
                                        ? Row(
                                      children: List.generate(
                                              user.eventsAction!.length > 2
                                                  ? 2
                                                  : user.eventsAction!.length,
                                              (index) {
                                                return ItemUserEventProfile(
                                                  event:
                                                      user.eventsAction![index],
                                                );
                                              },
                                            )

                                    ):Text("No Events"),
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
                              thickness: 0.5,
                              height: 0,
                            ),
                            GradientText(
                              text: 'About',
                              style: AppFonts.homeScreenText,
                              gradient: AppColors.buttonColor,
                            ).marginOnly(
                              top: 20.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(ScreenViewDescription(
                                  description: user.reference == null
                                      ? "No Description"
                                      : user.reference!.description ??
                                          "No Description",
                                ));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ReadMoreText(
                                      textAlign: TextAlign.start,
                                      user.reference == null
                                          ? "No Description"
                                          : user.reference!.description ??
                                              "No Description",
                                      trimLines: 1,
                                      colorClickableText: Colors.blue,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Read more',
                                      trimExpandedText: 'Show less',
                                      moreStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFA7713F),
                                      ),
                                      lessStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFA7713F),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 0.5,
                              height: 0,
                            ),
                            if (widget.isMatch == true)
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  margin: EdgeInsets.symmetric(vertical: 15.h),
                                  width: Get.width * .65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: Color(0xFFA7713F),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xFF1D1D1D),
                                            child: Icon(Icons.close,
                                                color: Colors.white),
                                          )),
                                      GestureDetector(
                                        child: CircleAvatar(
                                          radius: 22.r,
                                          backgroundColor: Color(0xFFA7713F),
                                          child: SvgPicture.asset(
                                            "assets/icons/icon_flah.svg",
                                          ).marginSymmetric(horizontal: 5.h),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if(Get.find<ControllerHome>().user.value!.user.goldenMember==1&&Get.find<ControllerHome>().user.value!.user.message_count!>0) {
                                            log("User id ${user.id}");
                                            Get.to(ScreenUserChat(
                                              usersList: [user],
                                            ));
                                          }
                                          else{
                                            FirebaseUtils.showError(
                                                'You have no swipes left. Please buy more swipes or become a golden member for unlimited swipes!'
                                            );
                                            Get.to(ScreenSubscription(isHome: true,));
                                          }
                                        },
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 22.r,
                                              backgroundColor:
                                                  Color(0xFF1D1D1D),
                                              child: SvgPicture.asset(
                                                "assets/icons/icon_chat.svg",
                                              ).marginSymmetric(
                                                  horizontal: 5.sp),
                                            ),
                                            // Positioned(
                                            //   top: 0.0,
                                            //   right: 0.sp,
                                            //   child: CircleAvatar(
                                            //     radius: 8.r,
                                            //     backgroundColor: Color(0xFFA7713F),
                                            //     child: Text(
                                            //       "20",
                                            //       style: TextStyle(
                                            //         fontSize: 7.sp,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          LikeController likeController =
                                              Get.put(LikeController());
                                          likeController.likeEntity(
                                              likedUserId: int.parse(user.id!));
                                        },
                                        child: GestureDetector(
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xFFA7713F),
                                            child: SvgPicture.asset(
                                              "assets/icons/icon_heart.svg",
                                            ).marginSymmetric(horizontal: 5.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      } else {
                        // User is not a golden member, and match is true, show upgrade option
                        return Container(
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
                                  Get.to(ScreenSubscription(isHome: true));
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
                      }
                    }).marginSymmetric(
                      vertical: 10.h,
                    ),
                    if (widget.isMatch == false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GradientText(
                            text: 'Subscription type',
                            style: AppFonts.homeScreenText,
                            gradient: AppColors.buttonColor,
                          ),
                          MyInputField(
                            padding: EdgeInsets.zero,
                            onTap: () {
                              Get.to(ScreenSubscriptionType());
                            },
                            hint: user.pmType ?? "No ",
                            suffix: Icon(
                              size: 25.h,
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            readOnly: true,
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 0.5,
                            height: 0,
                          ),
                          if(Get.find<ControllerHome>().user.value!.user.boostStatus=="0")CustomSelectbaleButton(
                            isSelected: true,
                            borderRadius: BorderRadius.circular(20),
                            imageUrl: "assets/icons/icon_flash_png.png",
                            gradient: AppColors.buttonColor,
                            onTap: () {
                              Get.to(ScreenBeSeenDetails());
                            },
                            width: width,
                            height: 52.h,
                            strokeWidth: 2,
                            titleButton: 'Boost',
                          ).marginOnly(
                            top: 20.sp,
                          ),
                          if (Get.find<ControllerHome>().user.value!.user.goldenMember == 0)
                            Container(
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
                                      Get.to(ScreenSubscription(isHome: true));
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
                            )
                        ],
                      ).marginSymmetric(
                        vertical: 10.h,
                      ),
                  ],
                ).marginSymmetric(horizontal: 20.w),
              ),
            );
          }),
    );
  }
}
