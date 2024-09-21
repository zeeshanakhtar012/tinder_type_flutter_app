import 'package:blaxity/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int? currentIndex;
  final bool hasNotification;
  final bool hasRequestNotification;
  final bool hasChatNotification;
  final Function(int) onItemTapped;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;

  CustomBottomNavigationBar({
    this.currentIndex,
    required this.hasChatNotification,
    required this.hasRequestNotification,
    required this.hasNotification,
    required this.onItemTapped,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
  });

  Widget _buildBottomNavigationItem({
    required String icon,
    required int index,
    bool hasNotification = false,
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/icons/$icon.svg",
              color: currentIndex == index ? selectedColor : unselectedColor,
              height: 30.h,  // Increase height
              width: 30.w,  // Increase width
            ),
          ),
          if (hasNotification)
            Positioned(
              top: 4.5.sp,
              right: 8.sp,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: AppColors.buttonColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: MediaQuery.sizeOf(context).height * .086.sp,
      clipBehavior: Clip.hardEdge,
      color: backgroundColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildBottomNavigationItem(
            icon: "icon_home_svg",
            index: 0,
          ),
          _buildBottomNavigationItem(
            icon: "icon_eventSection_svg",
            index: 1,
            hasNotification: hasNotification,
          ),
          _buildBottomNavigationItem(
            icon: "icon_event_svg",
            index: 2,
          ),
          _buildBottomNavigationItem(
            icon: "icon_chat_svg",
            hasNotification: hasChatNotification,
            index: 3,
          ),
          _buildBottomNavigationItem(
            icon: "icon_profile_svg",
            index: 4,
            hasNotification: hasRequestNotification,
          ),
        ],
      ),
    );
  }
}
