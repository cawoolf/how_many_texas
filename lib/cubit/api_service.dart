import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:dart_openai/dart_openai.dart';
import 'package:how_many_texas/constants/api_keys.dart';
import 'package:how_many_texas/constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

abstract class APIService {
  Future<String> fetchSearchImage(String search);

  Future<String> fetchChatCompletion(String search, String prompt);

  Future<String> fetchChatTTS(String numberText);
}

// With the GPT prompt, Returns the length and width of the object described in the user input
// With the TTS Prompt, returns the number spelled out in written English.
class ApiService implements APIService {
  @override
  Future<String> fetchChatCompletion(String userInput, String prompt) async {
    var messagesBody = [
      {"role": "system", "content": prompt},
      {"role": "user", "content": userInput}
    ];

    try {
      var response = await http.post(
        Uri.parse("$BASE_CHAT_URL/completions"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $OPEN_AI_API_KEY'
        },
        body: jsonEncode(
          {
            "model": GPT_CHAT_MODEL,
            "messages": messagesBody,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      late String result;

      if (jsonResponse['error'] != null) {
        print("api_service.dart line 49 -> json error occurred");
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }

      if (jsonResponse["choices"].length > 0) {
        // print("api_service.dart line 45 - response: $jsonResponse");

        result = jsonResponse["choices"][0]["message"]["content"].toString();

        print("api_service.dart line 57 -> result: $result");

        return result;
      }
    } catch (error) {
      print("api_service.dart line 62 error $error");
      rethrow;
    }

    return "Error";
  }

  @override
  Future<String> fetchChatTTS(String numberText) async {
    OpenAI.apiKey = OPEN_AI_API_KEY;

    Directory tempDir = await getTemporaryDirectory();
    String outputPath = tempDir.path;

    // The speech request.
    File speechFile = await OpenAI.instance.audio.createSpeech(
      model: "tts-1",
      input: numberText,
      voice: "onyx",
      responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
      outputDirectory: Directory(outputPath),
      outputFileName: "anas",
    );

// The file result.
    print('api_service.dart line 88 -> TTSPath : ${speechFile.path}');

    return speechFile.path;


  }

  @override
  Future<String> fetchSearchImage(String search) async {
    const String baseUrl = 'https://api.unsplash.com';
    const String accessKey = unsplash_access_key;

    String uri = '$baseUrl/photos/random?query=$search&client_id=$accessKey';

    final response = await http.get(
      Uri.parse(uri),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String imageUrl = data['urls']['regular'];

      return imageUrl;

    } else {
      return "unsplash error ${response.statusCode}";
    }
  }
}

