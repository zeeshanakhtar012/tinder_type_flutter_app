import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSplashButton extends StatefulWidget {
  final double width;
  final double height;
  final double? textSize;
  final double strokeWidth;
  final Gradient gradient;
  final String titleButton;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool? isLoading;
  final String? imageUrl;
   Color? buttonTextColor;

  CustomSplashButton({
    Key? key,
    required this.width,
    required this.height,
    required this.strokeWidth,
    required this.gradient,
    required this.titleButton,
    this.borderRadius = BorderRadius.zero,
    this.onTap,
    this.buttonTextColor = Colors.white,
    this.isSelected = false,
    this.isLoading = false,
    this.imageUrl, this.textSize,
  }) : super(key: key);

  @override
  _GradientBorderContainerState createState() => _GradientBorderContainerState();
}

class _GradientBorderContainerState extends State<CustomSplashButton> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    widget.buttonTextColor = Color(0xFF5B5B5B);
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant CustomSplashButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      setState(() {
        _isSelected = widget.isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.buttonTextColor=Colors.white;

    TextStyle buttonTextStyle = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: !_isSelected ?  widget.buttonTextColor:Colors.white,
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
        Future.delayed(Duration(milliseconds: 400), () {
          setState(() {
            _isSelected = false;
          });
        });
      },
      child: CustomPaint(
        painter: GradientBorderPainter(
          strokeWidth:1,
          gradient: widget.gradient,
          borderRadius: widget.borderRadius,
          isSelected: _isSelected,
        ),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
          ),
          child:(widget.isLoading==true)?Center(
            child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator()),
          ): Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.titleButton,
                style: buttonTextStyle,
              ),
              SizedBox(
                width: 5.w,
              ),
              if(widget.imageUrl!=null)
              Image(image: AssetImage("${widget.imageUrl}")),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;
  final BorderRadius borderRadius;
  final bool isSelected;

  GradientBorderPainter({
    required this.strokeWidth,
    required this.gradient,
    required this.borderRadius,
    this.isSelected = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final borderRect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final borderPath = Path()
      ..addRRect(borderRadius.toRRect(borderRect));

    canvas.drawPath(borderPath, paint);

    if (isSelected) {
      final selectedPaint = Paint()
        ..shader = gradient.createShader(rect) // Use gradient for fill
        ..style = PaintingStyle.fill;

      canvas.drawRRect(borderRadius.toRRect(borderRect), selectedPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
