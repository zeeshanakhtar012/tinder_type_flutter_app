import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;

  const GradientWidget({
    Key? key,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [
        Color(0xFFC09960),
        Color(0xFFBC935A),
        Color(0xFFB88C55),
        Color(0xFFB48750),
        Color(0xFFAE7D48),
        Color(0xFFA7713F),
        Color(0xFFA26837),
        Color(0xFF9C6031), // Gradient color 3
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
