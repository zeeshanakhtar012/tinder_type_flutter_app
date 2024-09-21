import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool? loading;
  final VoidCallback onTap;

  const SelectableButton({
    Key? key,
    required this.text,
    required this.isSelected,
     this.loading=false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.h,
        alignment: Alignment.center,
        // constraints: BoxConstraints(
        //   minWidth: 84.14.w,
        //   maxHeight: 44.28.h,
        // ),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFFA7713F) : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: loading!?SizedBox(
            height: 30.h,
            width: 30.w,
            child: CircularProgressIndicator()):Text(
          text,
          style: TextStyle(
            color: isSelected ?       Color(0xFFA7713F)
            : Colors.white,
          ),
        ),
      ),
    );
  }
}
