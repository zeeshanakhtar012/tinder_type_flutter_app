import 'package:blaxity/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  static TextStyle subtitle = TextStyle(
    fontSize: 15.sp,
    //15
    color: Color(0xffD0D0D0),
    fontFamily: "Arial",
    fontWeight: FontWeight.w400,
  );

  static TextStyle forgotScrItem = TextStyle(
    fontSize: 14.sp,
    //14
    color: Colors.white,
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleLogin = TextStyle(
    fontSize: 32.sp,
    //32
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );

  static TextStyle subscriptionTitle = TextStyle(
    fontSize: 20.sp,
    //20
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );
  static TextStyle amenitiesCategoryFont = TextStyle(
    fontSize: 20.sp,
    //20
    fontFamily: "Arial",
    color: Colors.white38,
  );
  static TextStyle subscriptionSubtitle = TextStyle(
    fontSize: 16.sp,
    //16
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );
  static TextStyle subscriptionDuration = TextStyle(
    fontSize: 15.87.sp,
    //16
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );
  static TextStyle subscriptionPrice = TextStyle(
    fontSize: 22.37.sp,
    //16
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );
  static TextStyle subscriptionPricePerWeek = TextStyle(
    fontSize: 17.sp,
    //16
    fontFamily: "Arial",
    fontWeight: FontWeight.w400,
  );
  static TextStyle subscriptionBlaxityGold = TextStyle(
    fontSize: 24.sp,
    //32
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );

  static TextStyle subtitleImagePickerButtonColor = TextStyle(
    fontSize: 14.sp,
    //14
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );
  static TextStyle titleWelcome = TextStyle(
    fontSize: 16.sp,
    fontFamily: "Arial",
    fontWeight: FontWeight.w500,
  );
  static TextStyle titleSetting = TextStyle(
    fontSize: 16.sp,
    fontFamily: "Arial",
    fontWeight: FontWeight.w500,
  );

  static TextStyle aboutDetails = TextStyle(
    fontSize: 18.sp,
    //18
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );


  static TextStyle resendEmailStyle = TextStyle(
    fontSize: 14.sp,
    color: Color(0xffD0D0D0),
    //14
    fontFamily: "Arial",
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleSuccessFullPassword = TextStyle(
    fontSize: 22.sp,
    //22
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );

  static TextStyle personalinfoAppBar = TextStyle(
    fontSize: 16.sp,
    //16
    fontFamily: "Arial",
    fontWeight: FontWeight.w400,
  );
  static TextStyle homeScreenText = TextStyle(
    fontSize: 24.sp,
    //32
    fontFamily: "Arial",
    fontWeight: FontWeight.w700,
  );
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
   Gradient? gradient;

  GradientText({
    required this.text,
    required this.style,
     this.gradient,
     this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    gradient=AppColors.buttonColor;
    return ShaderMask(
      shaderCallback: (bounds) => gradient!.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        textAlign: textAlign,
        text,
        style: style,
      ),
    );
  }
}
