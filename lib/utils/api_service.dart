import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:how_many_texas/constants/api_keys.dart';
import 'package:how_many_texas/constants/constants.dart';
import '../data/model/search_result.dart';
import 'package:http/http.dart' as http;

abstract class APIService {
  // Throws [Network Exception]
  Future<String?> fetchSearchImage(String search);
  Future<AIResult> fetchAIResult(String search);

}

class TestAPIRepository implements APIService {

   static const String testImagePath = 'assets/rattlesnake_1.png';
   Image testImage = Image.asset(testImagePath);


  // Testing
  @override
  Future<AIResult> fetchAIResult(String search) async {
    var messagesBody = [
      {"role": "system",
        "content" : GPT_PROMPT
      },
      {"role" : "user",
        "content" : search}];

    print("content: $search");

    try {
      var response = await http.post(
        Uri.parse("$BASE_CHAT_URL/completions"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $API_KEY'
        },
        body: jsonEncode(
          {
            "model": GPT_MODEL_1,
            "messages": messagesBody,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      late String result;

      if (jsonResponse['error'] != null) {
        print("error");
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }

      if (jsonResponse["choices"].length > 0) {
        print("response: $jsonResponse");
        log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        result = jsonResponse["choices"][0]["message"]["content"].toString();
        print("result: $result");
        return AIResult(search: search, result: result);
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }

    return AIResult(search: search, result: "Error");

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