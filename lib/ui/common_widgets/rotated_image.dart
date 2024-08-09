import 'package:flutter/material.dart';

class RotatedImage extends StatelessWidget {

  final double width;
  final double height;
  final double rotation;
  final Image image;

  const RotatedImage({
    super.key,
    required this.width,
    required this.height,
    required this.rotation, required this.image,

  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: rotation * (3.14/180),
    child: SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit:BoxFit.cover,
        child: image,),
    ));
  }
}