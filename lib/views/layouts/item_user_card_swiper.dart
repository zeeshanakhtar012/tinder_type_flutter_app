import 'dart:developer';
import 'dart:ui';

import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/constants/location_utils.dart';
import 'package:blaxity/controllers/controller_home.dart';
import 'package:blaxity/models/user.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/views/screens/screen_view_user_photos.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../constants/colors.dart';
import '../../constants/extensions/time_ago.dart';
import '../../constants/firebase_utils.dart';
import '../../constants/fonts.dart';
import '../../controllers/users_controllers/controller_get_user_all_data.dart';
import '../../widgets/custom_divider_gradient.dart';
import '../home_page/home_layouts/layout_couple_profile.dart';
import '../home_page/home_layouts/layout_single_user_profile.dart';

class ItemUserCardSwiper extends StatelessWidget {
  User user;
  VoidCallback onTap;

  ItemUserCardSwiper({Key? key, required this.user, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerHome controllerHome = Get.find<ControllerHome>();
    // log(user.partner1Name.toString());
    final height = MediaQuery
        .sizeOf(context)
        .height;
    final width = MediaQuery
        .sizeOf(context)
        .width;
    // String userName = user.userType == "couple" ? "${user.partner1Name} & ${user
    //     .partner2Name}" : "${user.fName}";
    List<String> imagesList = [];

    if (user.userType == "couple") {
      // Check if coupleRecentImage is not null
      if (user.coupleRecentImage != null && user.coupleRecentImage!.userRecentImages != null) {
        // Map the images from userRecentImages to the full URL
        imagesList = user.coupleRecentImage!.userRecentImages!
            .map((image) => APiEndPoint.imageUrl + image)
            .toList();
      }
    } else {
      // For single users, handle singleRecentImage
      if (user.singleRecentImage != null && user.singleRecentImage!.userRecentImages != null) {
        imagesList = user.singleRecentImage!.userRecentImages!
            .map((img) => APiEndPoint.imageUrl + img)
            .toList();
      }
    }



    // String description = (user.userType == "couple" ? user.commonCoupleData!.description ?? "No Description" : user.reference?.description ??
    //     "No Description").toString();
    List<String> desires = user.userType == "couple"
        ? (user.commonCoupleData?.desires ?? [])
        : (user.desires?.map((e) => e.title!).toList() ?? []);
    return InkWell(
      onTap: () {
        if (user.userType == "couple") {
          if (user.coupleId == null) {
            FirebaseUtils.showError("Couple Not completed Yet");
          }
          else {
            Get.to(LayoutCoupleProfile(coupleId: user.coupleId!, isMatch: true,));
          }
        }
        else {
          log("user.id ${user.id}");
          Get.to(LayoutSingleUserProfile(id: user.id!.toString(),isMatch: true,));
        }
      },
      child: IntrinsicHeight(
        child: SizedBox(
          height: 500.h,
          width: Get.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  // padding: EdgeInsets.symmetric(
                  //     vertical: 10.h, horizontal: 16.w),
                  margin: EdgeInsets.only(bottom: 16.h,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1D1D1D),
                    border: Border.all(
                      color: Color(0xFFA7713F),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            textAlign: TextAlign.start,
                            text: user.userType == "couple" ? "${user.partner1Name} & ${user
                                .partner2Name}" : "${user.fName}",
                            style: AppFonts.homeScreenText,
                            gradient: AppColors.buttonColor,
                          ).marginOnly(right: 5.w),
                          if(user.verification !=null&&user.verification!.status!="pending")SvgPicture.asset(
                            "assets/icons/icon_correct.svg",
                          ).marginSymmetric(horizontal: 5.w),
                          if(user.goldenMember == 1) SvgPicture.asset(
                            "assets/icons/icon_dimond.svg",
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              // Get.bottomSheet(,);
                              //
                              _showBottomSheet(context, user);
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/icon_menu.svg",
                            ),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 16.w),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/icon_location.svg",
                          ),
                          Obx(() {
                            return Get
                                .find<ControllerHome>()
                                .currentPosition
                                .value==null?Text("0 Km away",style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),):Text(
                              "${getDistance(Get
                                  .find<ControllerHome>()
                                  .currentPosition
                                  .value!
                                  .latitude, Get
                                  .find<ControllerHome>()
                                  .currentPosition
                                  .value!
                                  .longitude, double.tryParse(
                                  user.reference == null ? "0.0" : user
                                      .reference!.latitude ?? "0.0") ?? 0,
                                  double.tryParse(
                                      user.reference == null ? "0.0" : user
                                          .reference!.longitude ?? "0.0") ?? 0)
                                  .toStringAsFixed(1)} Km away",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                              ),
                            );
                          }).marginOnly(
                            left: 10.w,
                          ),
                        ],
                      ).marginSymmetric(horizontal: 16.w),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          alignment: Alignment.center,
                        //   padding: EdgeInsets.only(left: 3.sp),
                          height: 24.h,
                          width: 76.w,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.chatColor,
                                blurStyle: BlurStyle.inner,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(18.r),
                            border: Border.all(color: Color(0xFFA7713F)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Container(
                                height: 8.w,
                                width: 8.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (user.activeNow == "1")
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Spacer(),
                              Text(
                                (user.activeNow == "1")
                                    ? "Active Now"
                                    : "Offline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ).marginSymmetric(horizontal: 16.w,vertical: 8.h),


                      SizedBox(
                        height: 115.h,
                        child:
                        (imagesList.isNotEmpty) ?
                        GestureDetector(
                          onTap: (){
                         if(controllerHome.user.value!.user.goldenMember==0){
                           Get.to(ScreenSubscription(isHome: false,));
                         }
                         else{
                           Get.to(ScreenViewUserPhotos(imagesList: imagesList, UserName:user.userType == "couple" ? "${user.partner1Name} & ${user
                               .partner2Name}" : "${user.fName}" ));

                         }
                         },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: List.generate(
                                  imagesList.length>3?3:imagesList.length, (index) {
                                return Container(
                                    width: 72.w,
                                  height: 115.h,

                                    decoration: BoxDecoration(
                                        color: Color(0xFF353535),
                                        borderRadius: BorderRadius
                                            .circular(10),
                                        // border: Border.all(
                                        //   width: 2.w,
                                        //   color: Color(0xFFA7713F),
                                        // ),
                                        image: DecorationImage(

                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                imagesList[index]))
                                    ),
                                  child: controllerHome.user.value!.user.goldenMember==0?Container(
                                    color: Colors.black.withOpacity(0.8),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset("assets/icons/hide_image.svg")),
                                  ):SizedBox(),
                                ).marginOnly(right: 6.w);
                              })
                          ).marginOnly(top: 8.h
                          ),
                        ) : Center(child: Text("No images"))
                      ),
                     Obx(() {
                       return  (controllerHome.user.value!.user.goldenMember==0)?Align(
                         alignment: Alignment.center,
                         child: RichText(
                           text: TextSpan(
                             text: "Upgrade to",
                             style: TextStyle(
                               fontSize: 8.34.sp,
                               color: Colors.white,
                             ),
                             children: [
                               TextSpan(
                                 text: " Blaxity Gold",
                                 style: TextStyle(
                                   color: Color(0xFFA7713F),
                                   fontSize: 8.34.sp,
                                 ),
                               ),
                               TextSpan(
                                 text: "to view photos",
                                 style: TextStyle(
                                   fontSize: 8.34.sp,
                                   color: Colors.white,
                                 ),
                               ),
                             ],
                           ),
                         ).marginOnly(top: 8.h),
                       ):SizedBox();
                     }).marginSymmetric(horizontal: 16.w),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/icon_description.svg",
                          ),
                          Text(
                            "Description",
                            style: AppFonts.aboutDetails,
                          ).marginOnly(left: 8.w),
                        ],
                      ).marginSymmetric(horizontal: 16.w,vertical: 10.h),
                      Text(maxLines: 2,overflow: TextOverflow.ellipsis,(user.userType == "couple" ? user.commonCoupleData==null?"No Description": user.commonCoupleData!.description ?? "No Description" : user.reference?.description ??
                          "No Description").toString(),style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.start,).marginSymmetric(horizontal: 16.w,vertical: 5.h
                      ),
                      GradientDivider(
                        thickness: 0.5,
                        gradient: AppColors.whiteColorGradient.scale(.3),
                        width: Get.width,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/icon_fav.svg"),
                          Text(
                            "Desires",
                            style: AppFonts.aboutDetails,
                          ).marginOnly(left: 8.w),
                        ],
                      ).marginSymmetric(horizontal: 16.w),
                      (desires.isNotEmpty) ? Row(
                        children: [
                           Expanded(
                            child:  SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: List.generate(
                                      desires.length>3?3:desires.length, (index) {
                                    return Container(
                                      padding: EdgeInsets.only(left: 3.w),
                                      height: 28.92.h,
                                      width: 80.2.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Color(0xFFA7713F)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          desires[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.37.sp,
                                          ),
                                        ).marginOnly(left: 4.w),
                                      ),
                                    ).marginOnly(right: 10.w);
                                  })
                              ),
                            )
                          ),
                          GradientWidget(
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),

                        ],
                      ).marginSymmetric(horizontal: 16.w,vertical: 8.h): Text("No desires").marginSymmetric(horizontal: 16.w),
                      GradientDivider(
                        thickness: 0.5,
                        gradient: AppColors.whiteColorGradient.scale(.3),
                        width: Get.width,
                      ).marginSymmetric(
                        vertical: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/icon_age.svg")
                              .marginSymmetric(horizontal: 5.sp),
                          Text(
                            "Age",
                            style: AppFonts.aboutDetails,
                          ).marginOnly(left: 10.sp),
                          Text(
                            "${user.userType == "couple" ? user.partner_1_age?? "No Age" : user.age ?? "No Age"} ",
                            style: AppFonts.resendEmailStyle,
                          ).marginOnly(left: 10.sp),
                          (user.userType=="couple")?(user.partner1Sex=="Male"?SvgPicture.asset("assets/icons/icon_age01.svg"):SvgPicture.asset("assets/icons/icon_age02.svg")):user.reference!.sexuality=="Male"?SvgPicture.asset("assets/icons/icon_age01.svg"):SvgPicture.asset("assets/icons/icon_age02.svg")
                .marginSymmetric(horizontal: 5.sp),
                         user.userType!="couple"?SizedBox(): Text(
                            (user.partner_2_age ?? 0).toString(),
                            style: AppFonts.resendEmailStyle,
                          ).marginOnly(left: 10.sp),
                          (user.userType=="couple")?(user.partner2Sex=="Male"?SvgPicture.asset("assets/icons/icon_age01.svg"):SvgPicture.asset("assets/icons/icon_age02.svg")):SizedBox()
                              .marginSymmetric(horizontal: 5.sp),
                        ],
                      ).marginSymmetric(horizontal: 16.w),
                      GradientDivider(
                        thickness: 0.5,
                        gradient: AppColors.whiteColorGradient.scale(.3),
                        width: Get.width,
                      ).marginSymmetric(
                        vertical: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/icon_blaxity_journey.svg",
                          ).marginSymmetric(horizontal: 5.sp),
                          Text(
                            "Blaxity Journey",
                            style: AppFonts.aboutDetails,
                          ).marginOnly(left: 10.sp),
                          Spacer(),
                          Text(
                            "${getDaysSinceFromDateString(user.createdAt!)} Days",
                            style: AppFonts.subtitle,
                          ).marginOnly(left: 10.sp),
                        ],
                      ).marginSymmetric(horizontal: 16.w),
                      GradientDivider(
                        thickness: 0.5,
                        gradient: AppColors.whiteColorGradient.scale(.3),
                        width: Get.width,
                      ).marginSymmetric(
                        vertical: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: SvgPicture.asset("assets/icons/circle_down.svg"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 20.w,
            right: 20.w

          ),
          height: 150.h,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Get.find<ControllerHome>().blockUser(blockedUserId: user.id!.toString());
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 Text(
                    "Block ${user.userType != "couple" ? "${user.fName}" : "${user
                        .partner1Name}&${user.partner2Name}"}",
                    style: TextStyle(
                        color: Color(0xFFDD1A1A),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp
                    ),),
                    SvgPicture.asset("assets/icons/icon_block.svg")
                          ]
                ),
              ),
              Divider(color: Colors.white.withOpacity(.2),thickness: 0.7,).marginOnly(bottom: 10.h,),
              SizedBox(
                height: 1.h,
              ),
              InkWell(
                 onTap: () {
                   TextEditingController reason = TextEditingController();
                   Get.defaultDialog(
                       content: Container(
                         padding: EdgeInsets.all(20.sp),
                         height: 150.h,
                         // color: Colors.black,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children: <Widget>[
                             Text(
                               "Report ${user.userType != "couple" ? "${user
                                   .fName}" : "${user.partner1Name}&${user
                                   .partner2Name}"}",
                               style: AppFonts.subtitle,
                             ),
                             Container(
                               height: 50.h,
                               width: Get.width,
                               margin: EdgeInsets.only(top: 10.h),
                               padding: EdgeInsets.symmetric(horizontal: 10.w),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: Color(0xFFA7713F)),
                               ),
                               child: TextField(
                                 controller: reason,
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   hintText: "Reason",
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       onConfirm: () {
                         Get.find<ControllerHome>().reportUser(
                           reason: reason.text, reportedUserId: user.id!.toString(),);
                         Get.back();
                         Get.back();
                       },
                       onCancel: () {

                       }
                   );
                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                  Text(
                    "Report ${user.userType != "couple"
                        ? "${user.fName}"
                        : "${user.partner1Name}&${user.partner2Name}"}",
                    style: TextStyle(
                        color: Color(0xFFDD1A1A),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp
                    ),
                  ),
                     SvgPicture.asset("assets/icons/icon_report.svg"),
                   ]
                 ),
               ),
              Divider(color: Colors.white.withOpacity(.2),thickness: 0.7,).marginOnly(bottom: 10.h,),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
          ),
        );
      },
    );
  }


}
