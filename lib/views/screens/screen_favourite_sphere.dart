import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/controllers/controller_get_couple_sphere.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_couple_profile.dart';
import 'package:blaxity/views/home_page/home_layouts/layout_single_user_profile.dart';
import 'package:blaxity/views/screens/screen_subscription.dart';
import 'package:blaxity/widgets/gradient_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../constants/location_utils.dart';
import '../../controllers/controller_home.dart';
import '../../widgets/custom_drawer.dart';

class ScreenFavouriteSphere extends StatelessWidget {
  const ScreenFavouriteSphere({super.key});

  @override
  Widget build(BuildContext context) {

    // Get the controller instance
    final controllerGetCouplesSphere = Get.put(ControllerGetCouplesSphere());
    // Fetch the couple sphere data
    controllerGetCouplesSphere.getCoupleSphere();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: CustomDrawer(),
        appBar: AppBar(

          actions: [
            IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(Icons.notifications_none)).marginSymmetric(
              horizontal: 10.w,
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: RefreshIndicator(
          color: AppColors.appColor,
          onRefresh: () {
            return controllerGetCouplesSphere.getCoupleSphere();
          },
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    GradientText(text:
                    "Your Sphere",
                      gradient: AppColors.buttonColor,
                      style: AppFonts.titleLogin,
                    ),
                  ],
                ),
              ),
              // Buttons for views, likes, and network counts
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceE
                children: [
                  // View Count
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controllerGetCouplesSphere.getCoupleSphere(
                              filter: "views");
                        },
                        child: SvgPicture.asset("assets/icons/views.svg")
                      ),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${controllerGetCouplesSphere.viewCount.value}",
                              style: TextStyle(

                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA7713F),
                              ),
                            ).marginOnly(left: 5.sp),
                          ],
                        );
                      }).marginOnly(top: 10.h)
                    ],
                  ),
                  // Like Count
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controllerGetCouplesSphere.getCoupleSphere(
                              filter: "likes");
                        },
                        child:SvgPicture.asset("assets/icons/likes.svg")
                        //     : Container(
                        //   height: 75.h,
                        //   width: 75.w,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     border: Border.all(
                        //       color: Color(0xFFA7713F),
                        //     ),
                        //   ),
                        //   child: Center(
                        //     child: Icon(
                        //       Icons.favorite_border,
                        //       color: Color(0xFFA7713F),
                        //     ),
                        //   ),
                        // ),
                      ),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Like",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${controllerGetCouplesSphere.likeCount.value}",
                              style: TextStyle(

                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA7713F),
                              ),
                            ).marginOnly(left: 5.sp),
                          ],
                        );
                      }).marginOnly(top: 10.sp)
                    ],
                  ).marginSymmetric(horizontal: 20.w),
                  // Network Count
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controllerGetCouplesSphere.getCoupleSphere(
                              filter: "network");
                        },
                        child: SvgPicture.asset("assets/icons/network.svg")
                        // Container(
                        //   height: 75.h,
                        //   width: 75.w,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     border: Border.all(
                        //       color: Color(0xFFA7713F),
                        //     ),
                        //   ),
                        //   child: Center(
                        //     child: Icon(
                        //       CupertinoIcons.chat_bubble_fill,
                        //       color: Color(0xFFA7713F),
                        //     ),
                        //   ),
                        // ),
                      ),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Network",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${controllerGetCouplesSphere.networkCount
                                  .value}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA7713F),
                              ),
                            ).marginOnly(left: 5.sp),
                          ],
                        );
                      }).marginOnly(top: 10.sp)
                    ],
                  ),
                ],
              ).marginOnly(top: 20.h),
              Expanded(
                child: Obx(() {
                  if (controllerGetCouplesSphere.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }


                  // Check if there's no data
                  if (controllerGetCouplesSphere.combinedList.isEmpty) {
                    return Center(child: Text("No Data"));
                  }
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    itemCount: controllerGetCouplesSphere.combinedList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 158 / 270,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final user = controllerGetCouplesSphere
                          .combinedList[index];
                      return GestureDetector(
                        onTap: (){
             if ( Get.find<ControllerHome>().user.value!.user.goldenMember==0) {
               Get.to(ScreenSubscription(isHome: true));
             }
             else{
               if (user.userType=="couple") {
                 Get.to(LayoutCoupleProfile(coupleId: user.coupleId!,isMatch: true,));
               }
               else{
                 Get.to(LayoutSingleUserProfile(id: user.id!,isMatch: true,));
               }
             }
                        },
                        child: Container(
                          // height: 170.h,
                          // width: 170.w,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 199.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 3, color: Color(0xFFA7713F),),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          APiEndPoint.imageUrl +
                                              (user.userType == "couple"
                                                  ? (user.coupleRecentImage !=
                                                  null
                                                  ? (user.coupleRecentImage!
                                                  .userRecentImages != null &&
                                                  user.coupleRecentImage!
                                                      .userRecentImages!
                                                      .isNotEmpty
                                                  ? user.coupleRecentImage!
                                                  .userRecentImages!.first
                                                  : '')
                                                  : '')
                                                  : (user.singleRecentImage !=
                                                  null &&
                                                  user.singleRecentImage!
                                                      .userRecentImages!
                                                      .isNotEmpty &&
                                                  user.singleRecentImage!
                                                      .userRecentImages != null &&
                                                  user.singleRecentImage!
                                                      .userRecentImages!
                                                      .isNotEmpty
                                                  ? user.singleRecentImage!
                                                  .userRecentImages!.first
                                                  : ''))
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Get.find<ControllerHome>().user.value!.user.goldenMember==0?Container(
                                        color: Colors.black.withOpacity(0.3),
                                        // child: Align(
                                        //     alignment: Alignment.center,
                                        //     child: SvgPicture.asset("assets/icons/hide_image.svg")),
                                      ):SizedBox(),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          alignment: Alignment.center,
                                          // padding: EdgeInsets.symmetric(
                                          //     vertical: 7.h, horizontal: 20.w
                                          // ),
                                          height: 21.h,
                                          width: 86.w,
                                          decoration: BoxDecoration(
                                              gradient: AppColors.buttonColor,
                                              borderRadius: BorderRadius.vertical(
                                                  bottom: Radius.circular(15.r))
                                            // shape: BoxShape.circle,
                                            // border: Border.all(
                                            //   color: Color(0xFFA7713F),
                                            // ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${(user.matching_percentage ?? 0)
                                                  .toString()} % Match",
                                              style: TextStyle(color: Colors.white,
                                                  fontSize: 10.sp),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IntrinsicWidth(
                                      child: Container(
                                        height: 20.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        // width: 60.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Color(0xFFA7713F),
                                          ),
                                        ),
                                        child: Center(
                                          child: Obx(() {
                                            return Text(
                                              "${Get
                                                  .find<ControllerHome>()
                                                  .currentPosition
                                                  .value==null?"0.0":getDistance(Get
                                                  .find<ControllerHome>()
                                                  .currentPosition
                                                  .value!
                                                  .latitude, Get
                                                  .find<ControllerHome>()
                                                  .currentPosition
                                                  .value!
                                                  .longitude, double.tryParse(
                                                  user.reference == null
                                                      ? "0.0"
                                                      : user.reference!
                                                      .latitude ?? "0.0") ?? 0,
                                                  double.tryParse(
                                                      user.reference == null
                                                          ? "0.0"
                                                          : user.reference!
                                                          .longitude ?? "0.0") ??
                                                      0).toStringAsFixed(
                                                  1)} km away",
                                              style: TextStyle(
                                                fontSize: 9.36.sp,
                                                color: Colors.white,
                                              ),
                                            );
                                          }),
                                        ),
                                      ).marginOnly(
                                        top: 4.sp,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${user.userType == "couple" ? "${user
                                              .partner1Name}'&'${user
                                              .partner2Name}" : "${user.fName}"}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.36.sp,
                                          ),
                                        ),
                                      ),
                                      if(user.activeNow == "1") CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 3.r,
                                      ).marginOnly(
                                        left: 4.sp,
                                      ),
                                    ],
                                  ).marginOnly(
                                    top: 2.sp,
                                  ),
                                  Row(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return AppColors.buttonColor
                                              .createShader(bounds);
                                        },
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          size: 10,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          user.reference == null ? "No Location" : user
                                              .reference!.location ?? " No Location",

                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ).marginOnly(left: 5.sp),
                                      ),
                                    ],
                                  ).marginOnly(
                                    top: 2.sp,
                                  ),
                                  Row(
                                    children: [
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return AppColors.buttonColor
                                              .createShader(bounds);
                                        },
                                        child: Icon(
                                          Icons.transgender,
                                          size: 10,
                                        ),
                                      ),
                                      Text(
                                        (user.userType == "couple"?("${user.partner2Sex  }"+"&"+"${ user.partner1Sex}"):user.reference!.sexuality!),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13.sp,
                                        ),
                                      ).marginOnly(left: 5.sp),
                                    ],
                                  ).marginOnly(
                                    top: 2.sp,
                                  ),
                                ],
                              ).marginOnly(
                                top: 5.sp,
                                left: 5.sp,
                                right: 5.sp,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
            vertical: 15.sp,
          ),
        ),
      ),
    );
  }
}