import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

class SelectableTextRow extends StatefulWidget {
  final String text;

  SelectableTextRow({required this.text});

  @override
  _SelectableTextRowState createState() => _SelectableTextRowState();
}

class _SelectableTextRowState extends State<SelectableTextRow> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
             widget.text,
            style: TextStyle(
              color: isSelected? Color(0xFFA7713F): Colors.white,
              fontSize: 32.sp
            ),
          ),
          if (isSelected)
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.buttonColor.createShader(bounds);
              },
              child: Icon(
                Icons.done,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}
