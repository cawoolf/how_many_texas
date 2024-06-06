import 'package:flutter/material.dart';
import 'dart:math';

class RotatedImage extends StatelessWidget {

  final double width;
  final double height;
  final double rotation;
  final Image image;

  RotatedImage({
    Key? key,
    required this.width,
    required this.height,
    required this.rotation, required this.image,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: rotation * (3.14/180),
    child: SizedBox(
      width: width,
      height: height,
      child: image,
    ));
  }
}