import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenFullImagePreview extends StatelessWidget {
  final String imageUrl;

  const ScreenFullImagePreview({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Full Image', style: TextStyle(
          fontSize: 14.sp,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
