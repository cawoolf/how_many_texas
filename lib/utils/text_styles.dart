import 'package:flutter/material.dart';

class AppTextStyles {

  static TextStyle yeehawHeading = TextStyle(
    fontFamily: 'Smokum', // Reference the font family name
    fontSize: 64,
    fontWeight: FontWeight.bold, // Specify FontWeight.bold for the bold variant
      foreground: Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4
    ..color = Colors.black, // Set the color of the stroke,
  );
}