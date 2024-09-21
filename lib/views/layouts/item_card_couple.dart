import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../controllers/controller_item_card_couple.dart';
import '../../widgets/custom_divider_gradient.dart';

class ItemCardCouple extends StatefulWidget {
  // final double width;
  final String coupleName;
  final String coupleDistance;
  final String description;
  final String desire1;
  final String desire2;
  final String desire3;
  final String ageMale;
  final String ageFemale;
  final String blacityJourneyDays;


  @override
  State<ItemCardCouple> createState() => _ItemCardCoupleState();

  const ItemCardCouple({
    // required this.width,
    required this.coupleName,
    required this.coupleDistance,
    required this.description,
    required this.desire1,
    required this.desire2,
    required this.desire3,
    required this.ageMale,
    required this.ageFemale,
    required this.blacityJourneyDays,
  });
}
class _ItemCardCoupleState extends State<ItemCardCouple> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    final containerController = Get.put(ContainerController());
    final width = MediaQuery.sizeOf(context).width * 1;
    return Container(
      padding: EdgeInsets.all(18.0),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFA7713F),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GradientText(
                text: '${widget.coupleName}',
                style: AppFonts.homeScreenText,
                gradient: AppColors.buttonColor,
              ),
              SvgPicture.asset(
                "assets/icons/icon_correct.svg",
              ).marginSymmetric(horizontal: 5.sp),
              SvgPicture.asset(
                "assets/icons/icon_dimond.svg",
              ),
              Spacer(),
              SvgPicture.asset(
                "assets/icons/icon_menu.svg",
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/icon_location.svg",
              ),
              Text(
                "${widget.coupleDistance} Km away",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp,
                ),
              ).marginOnly(
                left: 6.sp,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 3.sp),
              height: 20.h,
              width: 70.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurStyle: BlurStyle.inner,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFA7713F)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 8.sp,
                    width: 8.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Active Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.37.sp,
                    ),
                  ).marginOnly(left: 4.sp),
                ],
              ),
            ),
          ).marginOnly(top: 8.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/image01.png")
                  .marginSymmetric(horizontal: 3.sp),
              Image.asset("assets/images/image02.png")
                  .marginSymmetric(horizontal: 3.sp),
              Image.asset("assets/images/image03.png")
                  .marginSymmetric(horizontal: 3.sp),
            ],
          ).marginOnly(top: 8.sp),
          RichText(
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
                  text: "Upgrade to",
                  style: TextStyle(
                    fontSize: 8.34.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).marginOnly(top: 8.sp),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/icon_description.svg",
              ),
              Text(
                "Description",
                style: AppFonts.aboutDetails,
              ).marginOnly(left: 8.sp),
            ],
          ).marginOnly(top: 15.sp),
          ReadMoreText(
            "${widget.description}",
            style: AppFonts.subtitle,
            trimLines: 1,
            trimLength: 115,
            colorClickableText: Color(0xFFA7713F),
            moreStyle: TextStyle(
              color: Color(0xFFA7713F),
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
            lessStyle: TextStyle(
              color: Color(0xFFA7713F),
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
          ).marginOnly(top: 5.sp),
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
              ).marginOnly(left: 8.sp),
            ],
          ).marginOnly(top: 15.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 3.sp),
                height: 28.92.h,
                width: 80.2.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFA7713F)),
                ),
                child: Center(
                  child: Text(
                    "${widget.desire1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.37.sp,
                    ),
                  ).marginOnly(left: 4.sp),
                ),
              ).marginSymmetric(
                horizontal: 8.w,
              ),
              Container(
                padding: EdgeInsets.only(left: 3.sp),
                height: 28.92.h,
                width: 80.2.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFA7713F)),
                ),
                child: Center(
                  child: Text(
                    "${widget.desire2}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.37.sp,
                    ),
                  ).marginOnly(left: 4.sp),
                ),
              ).marginSymmetric(
                horizontal: 8.w,
              ),
              Container(
                height: 28.92.h,
                width: 80.2.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFA7713F)),
                ),
                child: Center(
                  child: Text(
                    "${widget.desire3}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.37.sp,
                    ),
                  ).marginOnly(left: 4.sp),
                ),
              ).marginSymmetric(
                horizontal: 8.w,
              ),
            ],
          ).marginOnly(top: 8.sp),
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
                "${widget.ageMale}",
                style: AppFonts.resendEmailStyle,
              ).marginOnly(left: 10.sp),
              SvgPicture.asset("assets/icons/icon_age01.svg")
                  .marginSymmetric(horizontal: 5.sp),
              Text(
                "${widget.ageFemale}",
                style: AppFonts.resendEmailStyle,
              ).marginOnly(left: 10.sp),
              SvgPicture.asset("assets/icons/icon_age02.svg")
                  .marginSymmetric(horizontal: 5.sp),
            ],
          ).marginOnly(top: 8.sp),
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
                "${widget.blacityJourneyDays}",
                style: AppFonts.subtitle,
              ).marginOnly(left: 10.sp),
            ],
          ).marginOnly(top: 8.sp),
          GradientDivider(
            thickness: 0.5,
            gradient: AppColors.whiteColorGradient.scale(.3),
            width: Get.width,
          ).marginSymmetric(
            vertical: 5.h,
          ),
          Positioned(
            bottom: 0.0.sp,
            right: 0.0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: containerController.toggleExpand,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.3),
                  child: SvgPicture.asset(
                      "assets/icons/icon_down.svg"),
                ),
              ),
            ),
          ),
          if (containerController.isExpanded.value) ...[
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => containerController.onAvatarTap(0),
                    child: CircleAvatar(
                      backgroundColor: containerController.selectedIndex ==
                          0
                          ? Color(0xFFA7713F)
                          : Colors.grey.withOpacity(0.3),
                      child:
                      Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  // Add some spacing between avatars if needed
                  GestureDetector(
                    onTap: () => containerController.onAvatarTap(1),
                    child: CircleAvatar(
                      backgroundColor: containerController.selectedIndex ==
                          1
                          ? Color(0xFFA7713F)
                          : Colors.grey.withOpacity(0.3),
                      child: SvgPicture.asset(
                        "assets/icons/icon_flah.svg",
                      ).marginSymmetric(horizontal: 5.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => containerController.onAvatarTap(2),
                    child: CircleAvatar(
                      backgroundColor: containerController.selectedIndex ==
                          2
                          ? Color(0xFFA7713F)
                          : Colors.grey.withOpacity(0.3),
                      child: SvgPicture.asset(
                        "assets/icons/icon_chat.svg",
                      ).marginSymmetric(horizontal: 5.sp),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => containerController.onAvatarTap(3),
                    child: CircleAvatar(
                      backgroundColor: containerController.selectedIndex ==
                          3
                          ? Color(0xFFA7713F)
                          : Colors.grey.withOpacity(0.3),
                      child: SvgPicture.asset(
                        "assets/icons/icon_heart.svg",
                      ).marginSymmetric(horizontal: 5.sp),
                    ),
                  ),
                ],
              );
            }),
          ],
        ],
      ),
    );
  }
}
