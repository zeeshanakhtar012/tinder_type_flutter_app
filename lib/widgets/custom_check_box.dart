import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isSelected; // Use bool for selected state
  final String titleText;
  final ValueChanged<bool> onChanged; // Use bool type

  final TextStyle checkBoxTitleStyle = TextStyle(
    fontSize: 14.sp,
    color: Color(0xFFD0D0D0),
    fontFamily: "Arial",
    fontWeight: FontWeight.w400,
  );

  CustomCheckbox({
    required this.isSelected,
    required this.onChanged,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isSelected) {
          onChanged(true);
        }
      },
      child: Row(
        children: [
          Container(
            width: 19.w,
            height: 19.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Colors.white),
            ),
            child: isSelected
                ? Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
                : null,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            titleText,
            style: checkBoxTitleStyle,
          ),
        ],
      ),
    );
  }
}
