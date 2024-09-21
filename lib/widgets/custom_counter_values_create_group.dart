import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomCounter extends StatefulWidget {
  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$_counter',
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _incrementCounter,
              child: Icon(
                size: 24.sp,
                Icons.keyboard_arrow_up, color: Colors.white,
              ),
            ),
            InkWell(
              onTap: _decrementCounter,
              child: Icon(
                size: 24.sp,
                Icons.keyboard_arrow_down, color: Colors.white,
              ),
            ),
          ],
        ).marginOnly(
          left: 5.sp,
        ),
      ],
    );
  }
}