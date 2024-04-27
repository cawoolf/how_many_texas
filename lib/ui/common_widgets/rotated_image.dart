import 'package:flutter/material.dart';
import 'dart:math';

class RotatedImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const RotatedImage({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 2, // Rotate 90 degrees to the right (negative angle for clockwise rotation)
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}