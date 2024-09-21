import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_divider_gradient.dart';
import 'item_desires_home.dart';

class ItemCouple extends StatefulWidget {
  String coupleNames;
  String distance;
  String description;
  String ageMale;
  String ageFemale;
  // String blaxityJourney;
  String journeyTime;
  List<String> coupleImages = [];
  ItemCouple({
    required this.coupleNames,
    required this.distance,
    required this.description,
    required this.ageMale,
    required this.ageFemale,
    // required this.blaxityJourney,
    required this.journeyTime,

    super.key});

  @override
  State<ItemCouple> createState() => _ItemCoupleState();
}

class _ItemCoupleState extends State<ItemCouple> {
  bool _isExpanded = false;
  int _selectedIndex = -1;
  // int _selectedButtonIndex = -1;
  // double _sliderValue = 0.0;
  // int _selectedToggleIndex = 1;
  // void _onToggle(int index) {
  //   setState(() {
  //     _selectedToggleIndex = index;
  //   });
  // }
  // void _onButtonTap(int index) {
  //   setState(() {
  //     _selectedButtonIndex = index;
  //     // _showBottomSheetFilter(context);
  //   });
  // }
  void _onAvatarTap(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0)
        _showBottomSheet(context);
    });
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.sp),
          height: 150.h,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Block Sandy", style: TextStyle(
                    color: Colors.red,
                  ),),
                  Icon(CupertinoIcons.nosign, color: Colors.white,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Report user", style: TextStyle(
                    color: Colors.red,
                  ),),
                  Icon(CupertinoIcons.exclamationmark_octagon, color: Colors.white,),
                ],
              ).paddingOnly(
                top: 20.sp,
              ),
            ],
          ).marginSymmetric(
            horizontal: 15.sp,
          ),
        );
      },
    );
  }
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return  Container(
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
                text: '${widget.coupleNames}',
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
                "${widget.distance} Km away",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp,
                ),
              ).marginOnly(
                left: 10.sp,
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
            gradient: AppColors.buttonColor,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemDesiresHome(desireName: 'Soft Swap',),
              ItemDesiresHome(desireName: 'Hard Swap',),
              ItemDesiresHome(desireName: 'Group sex',),
              Icon(
                CupertinoIcons.forward,
                color: Color(0xFFA7713F),
              ),
            ],
          ).marginOnly(top: 8.sp),
          Row(
            children: [
              SvgPicture.asset("assets/icons/icon_age.svg")
                  .marginSymmetric(horizontal: 5.sp),
              Text(
                "${widget.ageMale}",
                style: AppFonts.aboutDetails,
              ).marginOnly(left: 10.sp),
              Text(
                "${widget.ageFemale}",
                style: AppFonts.resendEmailStyle,
              ).marginOnly(left: 10.sp),
              SvgPicture.asset("assets/icons/icon_age01.svg")
                  .marginSymmetric(horizontal: 5.sp),
              Text(
                "25",
                style: AppFonts.resendEmailStyle,
              ).marginOnly(left: 10.sp),
              SvgPicture.asset("assets/icons/icon_age02.svg")
                  .marginSymmetric(horizontal: 5.sp),
            ],
          ).marginOnly(top: 8.sp),
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
                "${widget.journeyTime} Days",
                style: AppFonts.subtitle,
              ).marginOnly(left: 10.sp),
            ],
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
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: _toggleExpand,
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(.3),
                child:  SvgPicture.asset(
                    "assets/icons/icon_down.svg"),
              ),
            ),
          ),
          if (_isExpanded) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _onAvatarTap(0),
                  child: CircleAvatar(
                    backgroundColor: _selectedIndex == 0
                        ? Color(0xFFA7713F)
                        : Colors.grey.withOpacity(0.3),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
                SizedBox(width: 10), // Add some spacing between avatars if needed
                GestureDetector(
                  onTap: () => _onAvatarTap(1),
                  child: CircleAvatar(
                    backgroundColor: _selectedIndex == 1
                        ? Color(0xFFA7713F)
                        : Colors.grey.withOpacity(0.3),
                    child: SvgPicture.asset(
                      "assets/icons/icon_flah.svg",
                    ).marginSymmetric(horizontal: 5.sp),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _onAvatarTap(2),
                  child: CircleAvatar(
                    backgroundColor: _selectedIndex == 2
                        ? Color(0xFFA7713F)
                        : Colors.grey.withOpacity(0.3),
                    child: SvgPicture.asset(
                      "assets/icons/icon_chat.svg",
                    ).marginSymmetric(horizontal: 5.sp),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _onAvatarTap(3),
                  child: CircleAvatar(
                    backgroundColor: _selectedIndex == 3
                        ? Color(0xFFA7713F)
                        : Colors.grey.withOpacity(0.3),
                    child: SvgPicture.asset(
                      "assets/icons/icon_heart.svg",
                    ).marginSymmetric(horizontal: 5.sp),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
