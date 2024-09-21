import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  String text;
  double? fontSize;
  VoidCallback? onTap;
  bool? isRound;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;
  Color? textColor;
  Color? buttonColor;
  Color? borderColor;
  Gradient? buttonGradient;
  bool? loading;
  bool? isBorder;

  @override
  _CustomButtonState createState() => _CustomButtonState();

  CustomButton({
    required this.text,
    this.fontSize,
    this.onTap,
    this.isRound,
    this.width,
    this.height,
    this.margin,
    this.textColor,
    this.buttonColor,
    this.borderColor,
    this.buttonGradient,
    this.loading = false,
    this.isBorder = false,
  });
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: widget.height ?? 54.h,
        width: widget.width ?? MediaQuery.of(context).size.width,
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: widget.isRound == true
              ? BorderRadius.circular(20.r)
              : BorderRadius.circular(10),

          // gradient: widget.buttonGradient ?? LinearGradient(
          //   colors: [Color(0xff353535), Color(0xff353535)],
          // ),
            color: widget.buttonColor??Color(0xff353535),
          border: Border.all(
            color: widget.isBorder! ? Color(0xFFA7713F): Color(0xFF353535),
          )// Check if buttonGradient is null and use black if it is
        ),
        child: widget.loading!
            ? CircularProgressIndicator(
          color: Colors.brown,
        )
            : Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSize ?? 20.sp,
            decoration: TextDecoration.none,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
