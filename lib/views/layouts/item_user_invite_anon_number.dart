import 'package:blaxity/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ItemInviteNumberAnonymous extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool? isImage;
  final bool? isLoading;
  final String? imageUrl;

  const ItemInviteNumberAnonymous({
    Key? key,
    required this.text,
    this.isImage,
    this.imageUrl,
    this.isLoading=false,
    required this.onTap,
  }) : super(key: key);

  @override
  _ItemInviteNumberAnonymousState createState() => _ItemInviteNumberAnonymousState();
}

class _ItemInviteNumberAnonymousState extends State<ItemInviteNumberAnonymous> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = true;
        });
        widget.onTap();

        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            _isTapped = false;
          });
        });
      },
      child: Container(
        height: 54.h,
        width: 335.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFA7713F),),
          gradient: _isTapped ? AppColors.buttonColor : AppColors.blackColorGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: (widget.isLoading==true)?SizedBox(
            height: 35.h,
            width: 35.w,
            child: CircularProgressIndicator()):Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(color: Colors.white, fontSize: 20.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            if (widget.isImage == true)
              SvgPicture.asset(
                height: 20.88.h,
                width: 20.88.w,
                widget.imageUrl!,
              ).paddingOnly(
                left:5.w,
              ),
          ],
        ),
      ),
    );
  }
}
