import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CustomToggleSwitchFilter extends StatefulWidget {
  final List<String> labels;
  final ValueChanged<int> onToggle;
  final int initialIndex;

  CustomToggleSwitchFilter({
    Key? key,
    required this.labels,
    required this.onToggle,
    this.initialIndex = 0,
  })  : assert(labels.length == 3, "CustomToggleSwitch requires exactly 3 labels"),
        super(key: key);

  @override
  _CustomToggleSwitchFilterState createState() => _CustomToggleSwitchFilterState();
}

class _CustomToggleSwitchFilterState extends State<CustomToggleSwitchFilter> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onToggle(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 335.w,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFF353535),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Row(
        children: List.generate(widget.labels.length, (index) {
          bool isActive = _selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => _onToggle(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: isActive ? AppColors.buttonColor : null,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.labels[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
