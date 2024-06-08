import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:how_many_texas/utils/api_keys.dart';
import 'model/search_result.dart';
import 'package:http/http.dart' as http;

abstract class APIRepository {
  // Throws [Network Exception]
  Future<String?> fetchSearchImage(String search);
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
      return AIResult(search: search, result: random.nextInt(100).toString());
    });
  }

  @override
  Future<String?> fetchSearchImage(String search) async {
    const String baseUrl = 'https://api.unsplash.com';
    const String accessKey = unsplash_access_key;

    final response = await http.get(
      Uri.parse('$baseUrl/photos/random?query=$search&client_id=$accessKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['urls']['regular'];
    } else {
      return "unsplash error ${response.statusCode}";
    }

    }

}