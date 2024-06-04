import 'package:flutter/material.dart';
import 'dart:math';

class RotatedImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double rotation;

  const RotatedImage({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.rotation,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * (3.14/180), // Converts radians to degrees for rotation
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}