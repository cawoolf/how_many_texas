import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'model/search_image.dart';
import 'model/search_result.dart';

abstract class APIRepository {
  // Throws [Network Exception]
  Future<SearchImage> fetchSearchImage(String search);
  Future<AIResult> fetchAIResult(String search);

}

class TestAPIRepository implements APIRepository {

   static const String testImagePath = 'assets/rattlesnake_1.png';
  Image testImage = Image.asset(testImagePath);


  // Testing
  @override
  Future<AIResult> fetchAIResult(String search) {
    return Future.delayed(const Duration(seconds: 1),(){
      final random = Random();
      return AIResult(search: search, aiResult: random.nextInt(100).toString());
    });
  }

  @override
  Future<SearchImage> fetchSearchImage(String search) {
    return Future.delayed(const Duration(seconds: 1),(){
      final random = Random();
      return SearchImage(search: search, searchImage: testImage);
    });
  }

}