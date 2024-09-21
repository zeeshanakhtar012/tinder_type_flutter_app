import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemDesiresHome extends StatelessWidget {
  String desireName;
  ItemDesiresHome({

    required this.desireName,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.sp),
      height: 40.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFA7713F)),
      ),
      child: Center(
        child: Text(
          "${desireName}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.37.sp,
          ),
        ).marginOnly(left: 4.sp),
      ),
    );
  }
}
