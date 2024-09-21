import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';

class ItemProfileDetails extends StatelessWidget {
  final String detail;
  final String ageFirstPerson;
  final String ageSecondPerson;
  final bool isGrey;

  const ItemProfileDetails({
    super.key,
    required this.detail,
    required this.ageFirstPerson,
    required this.ageSecondPerson,
    required this.isGrey,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;

    return Container(
      height: 54.h,
      width: width,
      decoration: BoxDecoration(
        color: isGrey ? Colors.grey.withOpacity(.3) : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GradientText(
              text: detail,
              style: AppFonts.forgotScrItem,
              gradient: AppColors.buttonColor,
            ),
          ),
          Expanded(
            child: Text(
              ageFirstPerson,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              ageSecondPerson,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ).marginSymmetric(horizontal: 10.w),
    );
  }
}
