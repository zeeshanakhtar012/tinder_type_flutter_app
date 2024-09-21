import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../views/home_page/home_layouts/layout_blog.dart';
import '../views/home_page/home_layouts/layout_event.dart';

class CustomToggleSwitch extends StatelessWidget {
  final List<String> labels;
  final Function(int) onToggle;
  final int selectedIndex;

  CustomToggleSwitch({
    required this.labels,
    required this.onToggle,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: Get.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(labels.length, (index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              onToggle(index);
              _navigateToScreen(index);
            },
            child: Container(
              constraints: BoxConstraints(
                minHeight: 40.h,
                minWidth: 80.w,
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: isSelected
                  ? BoxDecoration(
                gradient: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(20),
              )
                  : null,
              child: Center(
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Get.to(() => LayoutEvent());
        break;
      case 1:
        Get.to(() => LayoutBlog());
        break;
      case 2:
        // Get.to(() => ScreenEventDetails());
        break;
      default:
        Get.snackbar('Error', 'Unknown option selected.');
    }
  }
}
