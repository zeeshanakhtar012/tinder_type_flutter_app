import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/extensions/time_ago.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/layouts/item_event_profile.dart';
import 'package:blaxity/views/screens/screen_view_description.dart';
import 'package:blaxity/views/screens/screen_view_events.dart';
import 'package:blaxity/views/screens/screen_view_user_photos.dart';
import 'package:blaxity/views/screens/single_user_screens/screen_blaxiter_subscription_single_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:blaxity/constants/colors.dart';
import 'package:blaxity/controllers/controller_home.dart';

// import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_start_verification.dart';
import 'package:blaxity/widgets/my_input_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_divider_gradient.dart';
import '../../../widgets/custom_selectable_button.dart';
import '../../controllers/controller_event.dart';
import '../../models/event.dart';
import '../screens/screen_be_seen_details.dart';
import '../screens/screen_event_edit_profile.dart';
import '../screens/screen_subscription.dart';
import '../screens/screen_subscription_type_profile.dart';
import 'item_profile_details.dart';

class LayoutClubProfile extends StatelessWidget {
  ControllerHome _controllerHome = Get.put(ControllerHome());
  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    _controllerHome.fetchUserInfo();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.white,
        //   ),
        // ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ScreenEventEditProfile());
              },
              icon: SvgPicture.asset("assets/icons/edit.svg")),
          IconButton(
              onPressed: () {
                Get.to(ScreenEventEditProfile());
              },
              icon: SvgPicture.asset("assets/icons/setting.svg")),
        ],
        title: Image.asset(
            height: 53.h,
            width: 42.w,
            "assets/images/image_profile_appBar.png"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          _controllerHome.fetchUserInfo();
          return Future.delayed(Duration(seconds: 1));
        },
        child: Obx(() {
          if (_controllerHome.user.value == null) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            var user = _controllerHome.user.value!.user;
            Club club = user.clubs!.first;
            List<String> imageList = user.userType == "club_event_organizer"
                ? club.recentImages!.map((e) => APiEndPoint.clubImage + e.toString()).toList()
                : user.singleRecentImage!.userRecentImages!.map((e) => APiEndPoint.imageUrl + e.toString()).toList();
            return SingleChildScrollView(
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
                              image: NetworkImage(APiEndPoint.imageUrl +
                                  "${user.userType == "club_event_organizer" ? club.logo ?? "" : user.profile!}"))),
                    ),
                  ),
                  Container(
                    width: 336.w,
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
                          text: '${_controllerHome.user.value!.user.fName}',
                          style: AppFonts.homeScreenText,
                          gradient: AppColors.buttonColor,
                        ),
                        (_controllerHome.user.value!.user.goldenMember == 1)
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
                      height: 30.05.h,
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
                          user.pmType??"Free",
                          style: AppFonts.subscriptionDuration,
                        ),
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
                                (user.scores?? 0).toString(),
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
                                getDaysSinceFromDateString(user.createdAt!).toString(),
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
                            gradient:
                            _controllerHome.user.value!.user.verified == 1
                                ? AppColors.buttonColor
                                : null,
                            border: Border.all(
                              color: Color(0xFFA7713F),
                            )),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                _controllerHome.user.value!.user.verified == 1  ? Icons.done : Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                textAlign: TextAlign.center,
                                _controllerHome.user.value!.user.verified == 1
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
                        horizontal: 10.sp,
                      ),
                    ],
                  ),
                  if (_controllerHome.user.value!.user.verified == 0)
                    Container(
                      // height: height*.35.h,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFA7713F),
                          )),
                      child: Column(
                        children: [
                          SvgPicture.asset("assets/icons/icon_right_tick.svg")
                              .marginOnly(
                            top: 10.sp,
                            bottom: 10.sp,
                          ),
                          Text(
                            "Verify Your Profile",
                            style: AppFonts.titleSuccessFullPassword,
                          ),
                          Text(
                                  style: AppFonts.subtitle,
                                  "Enhance your credibility by verifying\nyour profile.")
                              .marginSymmetric(
                            vertical: 8.sp,
                          ),
                          CustomSelectbaleButton(
                            onTap: () {
                              Get.to(ScreenVerification());
                            },
                            borderRadius: BorderRadius.circular(20),
                            width: Get.width * .6.w,
                            height: 54.h,
                            strokeWidth: 1,
                            gradient: AppColors.buttonColor,
                            titleButton: "Start Verification",
                          ),
                        ],
                      ),
                    ).marginSymmetric(vertical: 6.h),
                  GradientText(
                    text: 'Photos',
                    style: AppFonts.homeScreenText,
                    gradient: AppColors.buttonColor,
                  ).marginSymmetric(vertical: 6.h),
                  if (imageList.isNotEmpty)
                    GestureDetector(
                      onTap: (){
                        Get.to(ScreenViewUserPhotos(imagesList: imageList, UserName: user.fName!));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                imageList.length>3?3:imageList.length,
                                (index) => Container(
                                        width: 97.w,
                                        height: 152.h,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF353535),
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              width: 2.w,
                                              color: Color(0xFFA7713F),
                                            ),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(imageList[index]))))
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
                  Divider(color: Colors.white,thickness: 0.3,height: 0,),
                  // GradientText(
                  //   text: 'Connections',
                  //   style: AppFonts.homeScreenText,
                  //   gradient: AppColors.buttonColor,
                  // ).marginSymmetric(vertical: 6.h),
                  // if(user.matches!=null && user.matches!.isNotEmpty)Row(
                  //   children: List.generate(user.matches!.length, (index) =>  Container(
                  //     height: 39.33.h,
                  //     width: 39.33.w,
                  //     padding: EdgeInsets.all(4.0),
                  //     decoration: BoxDecoration(
                  //       // gradient: AppColors.buttonColor,
                  //       border: Border.all(
                  //         width: 2.w,
                  //         color: Color(0xFFA7713F),
                  //       ),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         // ShaderMask(
                  //         //   shaderCallback: (Rect bounds) {
                  //         //     return AppColors.buttonColor.createShader(bounds);
                  //         //   },
                  //         //   child: event.attendees![index].userType=="couple" ? Icon(
                  //         //     Icons.group,
                  //         //     size: 15.h,
                  //         //   ): Icon(
                  //         //     Icons.person,
                  //         //     size: 15.h,
                  //         //   ),
                  //         // ),
                  //         // Text(event.attendees![index].userType=="couple"?"${event.attendees![index].partner1Name![0].toUpperCase()}&${event.attendees![index].partner2Name![0].toUpperCase()}" : event.attendees![index].fName![0].toUpperCase(), style: TextStyle(
                  //         //   fontSize: 6.sp,
                  //         //   fontWeight: FontWeight.bold,
                  //         //   color: Colors.white,
                  //         // ),
                  //         // ),
                  //       ],
                  //     ),
                  //   ),),
                  // ).marginSymmetric(vertical: 6.h),
                  // Divider(
                  //   color: Colors.white,
                  // ),
                  GradientText(
                    text: 'Events',
                    style: AppFonts.homeScreenText,
                    gradient: AppColors.buttonColor,
                  ).marginSymmetric(vertical: 6.h),
                   (user.eventsAction != null && user.eventsAction!.isNotEmpty)?
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
                    ):Row(
                      children: [
                        Text("No Events",style: TextStyle(color: Colors.white),).marginSymmetric(vertical: 6.h),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 24,
                        ),
                      ],
                    ),
                  Divider(
                    thickness: .3,
                    color: Colors.white,
                  ),
                  GradientText(
                    text: 'About',
                    style: AppFonts.homeScreenText,
                    gradient: AppColors.buttonColor,
                  ).marginSymmetric(vertical: 6.h),
                  GestureDetector(
                    onTap: (){
                      Get.to(ScreenViewDescription(description: user.reference?.description?? "No Description",));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ReadMoreText(
                            user.reference != null
                                ? user.reference!.description?? "No Description"
                                : "No Description",
                            trimLines: 2,
                            colorClickableText: Color(0xFFA26837),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read More',
                            trimExpandedText: 'Read Less',
                            style: TextStyle(
                                fontSize: 15.sp, color: Color(0xffD3D3D3)),
                            moreStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 24,
                        ),
                      ],
                    ).marginSymmetric(vertical: 6.h),
                  ),
                  Divider(color: Colors.white,thickness: .3,height: 0,),
                  GradientText(
                    text: 'Subscription type',
                    style: AppFonts.homeScreenText,
                    gradient: AppColors.buttonColor,
                  ).marginSymmetric(vertical: 6.h),
                  Row(children: [
                    Text("${user.pmType}",style: TextStyle(color: Colors.white),),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                    ),
                  ],),
                  Divider(
                    thickness: 0.3,
                    // height: .07.h,
                    color: Colors.white,
                  ),

                  if(user.goldenMember==0)Container(
                    height: 184.h,
                    width: 335.w,
                    margin: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Color(0xff1D1D1D),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFFA7713F),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upgrade to Gold",
                          style: AppFonts.titleSuccessFullPassword,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Subscribe ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xffD0D0D0),
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text: "Blaxity Gold ",
                                style: TextStyle(
                                  color: Color(0xFFA26837),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text:
                                "to view full profiles\nand much more.",
                                style: TextStyle(
                                  color: Color(0xffD0D0D0),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                )),
                          ]),
                        ).marginSymmetric(
                          vertical: 6.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ScreenSubscription(isHome: false,));
                          },
                          child: Container(
                            height: 42.27.h,
                            width: 262.22.w,
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(15.66.r),
                            ),
                            child: Center(
                              child: Text(
                                "View  subscription plans",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.66.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ).paddingOnly(
                            top: 15.h,
                          ),
                        ).marginSymmetric(
                          vertical: 10.h,
                        ),
                      ],
                    ),
                  ),

                  if(user.boostStatus=="0") CustomSelectbaleButton(
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
                  ).marginSymmetric(
                    vertical:15.h.sp,
                  ),



                ],
              ),
            );
          }
        }).marginSymmetric(horizontal: 20.w),
      ),
    );
  }
}
