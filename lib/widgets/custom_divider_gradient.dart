import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final double thickness;
  final double width;
  final Gradient gradient;

  const GradientDivider({
    Key? key,
    this.thickness = 1.0,
    required this.gradient, required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: thickness,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
    );
  }
}
