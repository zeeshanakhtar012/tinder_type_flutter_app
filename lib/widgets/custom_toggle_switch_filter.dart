import 'package:blaxity/views/screens/screen_go_out_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleSwitch extends StatefulWidget {
  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isFirstActive = true;

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenGoOut()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isFirstActive = true;
            });
          },
          child: Container(
            height: 27.h,
            width: 167.w,
            decoration: BoxDecoration(
              color: isFirstActive ? Color(0xFFA7713F) : Color(0xff1D1D1D),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5)
              ),
            ),
            child: Center(child: Text("Relevance", style: TextStyle(color: Colors.white))),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isFirstActive = false;
            });
            _navigateToNextScreen();
          },
          child: Container(
            height: 27.h,
            width: 167.w,
            decoration: BoxDecoration(
              color: isFirstActive ? Color(0xff1D1D1D) : Color(0xFFA7713F),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)
              ),
            ),
            child: Center(child: Text("Date", style: TextStyle(color: Colors.white))),
          ),
        ),
      ],
    );
  }
}