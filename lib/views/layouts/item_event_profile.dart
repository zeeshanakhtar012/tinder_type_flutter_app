import 'package:blaxity/constants/ApiEndPoint.dart';
import 'package:blaxity/models/event_action.dart';
import 'package:blaxity/models/user.dart' as e;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/controller_event.dart';
import '../../models/event.dart';

class ItemEventProfile extends StatelessWidget {
  Event event;
  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112.w,
      decoration: BoxDecoration(
        color: Color(0xFF1D1D1D), // Background color for the whole container
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        children: [
          // Image and Public label container
          Stack(
            children: [
              // Image
              Container(
                height: 94.89.h,
                width: 112.44.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    topRight: Radius.circular(5.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage("${APiEndPoint.imageUrl+event.image!}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Public label
              Align(
                alignment: Alignment.topCenter,
                // top: 0.h,
                // left: 0.w,
                // right: 0.w,
                child: Container(
                  height: 12.h,
                  width: 47.w,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "${event.privacy=="0"?"Public":"Private"}",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content below the image
          Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${event.title!}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/loc.svg"),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "${event.location!}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 4.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/eve.svg"),
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      "${event.createdAt}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/time.svg"),
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      "${event.time}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/peo.svg"),
                    ),
                    // SizedBox(width: 5.sp),
                    // Text(
                    //   "${event.!.length} Member",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 5.sp,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ItemEventProfile({
    required this.event,
  });
}
class ItemUserEventProfile extends StatelessWidget {
  EventAction event;
  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112.w,
      decoration: BoxDecoration(
        color: Color(0xFF1D1D1D), // Background color for the whole container
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        children: [
          // Image and Public label container
          Stack(
            children: [
              // Image
              Container(
                height: 94.89.h,
                width: 112.44.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    topRight: Radius.circular(5.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(""),
                    // image: NetworkImage("${APiEndPoint.imageUrl+event.!}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Public label
              Align(
                alignment: Alignment.topCenter,
                // top: 0.h,
                // left: 0.w,
                // right: 0.w,
                child: Container(
                  height: 12.h,
                  width: 47.w,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Private",
                      // "${event.=="0"?"Public":"Private"}",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content below the image
          Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${event.title!}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/loc.svg"),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "${event.location!}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 4.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/eve.svg"),
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      "${event.createdAt}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/time.svg"),
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      "${event.time}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return AppColors.buttonColor.createShader(bounds);
                      },
                      child: SvgPicture.asset("assets/icons/peo.svg"),
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      "No Data Member",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).marginOnly(right: 5.w);
  }

  ItemUserEventProfile({
    required this.event,
  });
}
