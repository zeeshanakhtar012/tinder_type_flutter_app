import 'package:flutter/material.dart';

class ItemCategory extends StatefulWidget {
  final double width;
  final double height;
  final double strokeWidth;
  final Gradient gradient;
  final Widget child;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final bool isSelected;

  const ItemCategory({
    Key? key,
    required this.width,
    required this.height,
    required this.strokeWidth,
    required this.gradient,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _GradientBorderContainerState createState() => _GradientBorderContainerState();
}

class _GradientBorderContainerState extends State<ItemCategory> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant ItemCategory oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected) {
      setState(() {
        _isSelected = widget.isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: CustomPaint(
        painter: GradientBorderPainter(
          strokeWidth: widget.strokeWidth,
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
          child: Center(
            child: widget.child,
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
