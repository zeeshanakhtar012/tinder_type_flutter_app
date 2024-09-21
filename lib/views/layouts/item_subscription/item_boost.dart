import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../models/boost.dart';

class ItemBoost extends StatelessWidget {
  Boost boost;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    return Column(
      children: [
        Container(
          height: 136.h,
          width: 239.13.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.33),
            border: Border.all(
              color: Color(0xFFA7713F),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      height: 28.92.h,
                      width: 97.47.w,
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          boost.name,
                          style: AppFonts.subscriptionDuration,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "\$ ${boost.price} / ",
                            style: AppFonts.subscriptionPrice,
                          ),
                          TextSpan(
                            text: "ea",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.67.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              // InkWell(
              //   onTap: () {
              //     // Get.to(ScreenSubscriptionDetails(
              //     //   subscriptionDescriptionTitle: subscriptionDescriptionTitle,
              //     //   subscriptionPriceTitle: subscriptionPriceTitle,
              //     //   subscriptionDurationTitle: subscriptionDurationTitle,
              //     //   subscriptionPerWeekTitle: subscriptionPerWeekTitle,
              //     // ));
              //   },
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         GradientText(
              //           text: "Test",
              //           style: AppFonts.subscriptionSubtitle,
              //           gradient: AppColors.buttonColor,
              //         ),
              //         ShaderMask(
              //           shaderCallback: (Rect bounds) {
              //             return AppColors.buttonColor.createShader(bounds);
              //           },
              //           child: Icon(
              //             Icons.keyboard_arrow_down,
              //             size: 24,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 28.92.h,
            width: 217.w,
            decoration: BoxDecoration(
              gradient: AppColors.buttonColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Boost",
                    style: AppFonts.subscriptionDuration,
                  ),
                  SvgPicture.asset("assets/icons/boost.svg")
                ],
              ),
            ),
          ),
        ),
      ],
    ).marginSymmetric(vertical: 10.h);
  }

  ItemBoost({
    required this.boost,
    required this.onTap,
  });
}
