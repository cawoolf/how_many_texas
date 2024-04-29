import 'package:flutter/material.dart';
import 'package:how_many_texas/utils/colors.dart';

class AppTextStyles {
  static TextStyle welcomePageTextStyle = const TextStyle(
    fontFamily: 'Smokum', // Reference the font family name
    fontSize: 64,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 4,
        offset: Offset(1, 1),
      ),
    ],
  );

  static TextStyle homeTextStyle = const TextStyle(
    fontFamily: 'Smokum',
    fontSize: 38,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 4.0,
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 4,
        offset: Offset(1, 1),
      ),
    ],
  );



  static TextStyle loadingPageHeaderTextStyle = const TextStyle(
    fontFamily: 'Chunk', // Reference the font family name
    fontSize: 64,
    fontWeight: FontWeight.normal,
    color: Colors.black);


  static TextStyle loadingPageFooterTextStyle = const TextStyle(
      fontFamily: 'Chunk', // Reference the font family name
      fontSize: 30,
      fontWeight: FontWeight.normal,
      color: Colors.black);
}