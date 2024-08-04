
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:how_many_texas/constants/constants.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/utils/texas_calculator.dart';
import 'app_state.dart';
import 'package:how_many_texas/utils/api_service.dart';

class AppCubit extends Cubit<AppState> {
  final APIService _apiRepository;

  AppCubit(this._apiRepository) :super(const WelcomePageState());

  Future<void> apiRequests(String userInput) async {
    try {
      emit(const APILoadingState());
      final searchImageURL = await _apiRepository.fetchSearchImage(userInput); // Calls the UnSplash AIP to return a random image of the user input
      Image searchImage = await _loadImage2(searchImageURL); // Loads the image provided by the URL


      final objectDimensions = await _apiRepository.fetchChatCompletion(userInput, GPT_PROMPT); // Calls OpenAI API to return the dimensions of the object the user inputs to the search field
      final finalNumberResult = calculateHowManyTexas(objectDimensions); // Calculates how many times the object can fit inside of Texas
      final finalNumberResultToWords = await _apiRepository.fetchChatCompletion(calculateHowManyTexas(objectDimensions), TTS_PROMPT); // Calculates how many times the object fits into Texas, and then calls the API to return the number in written english.
      final String fullText = "$finalNumberResultToWords $userInput can fit inside of Texas"; // Full text to be converted to audio
      final ttsFilePath = await _apiRepository.fetchChatTTS(fullText); // Submits the result of the finalNumberToWords to the OpenAI TTS API to generate an audio file, and store it to the file path, and returns the file path

      SearchResult aiResult = SearchResult(search: userInput,searchImage: searchImage, objectDimensionsResult: objectDimensions, finalNumberResult: finalNumberResult, TTS_PATH: ttsFilePath);

      emit(APILoaded(aiResult));

    } catch (error) {

      emit(APIError(error.toString()));
    }
  }

  Image _loadImage(String? searchImageURL) {
    return Image.network(searchImageURL!, fit: BoxFit.cover);
  }

  Future<Image> _loadImage2(String? searchImageURL) async {

    if (searchImageURL != null) {
      return Image.network(
        searchImageURL,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return Center(child: Text('Failed to load image'));
        },
      );
    } else {
      return Image.network('error_image_url'); // You can return a placeholder/error image here
    }
  }

  String calculateHowManyTexas(String objectDimensions) {
    TexasCalculator texasCalculator = TexasCalculator();
    return texasCalculator.calculateFitTimesFromAPIResult(objectDimensions);
  }

  Future<void> playNumbersAudio(String speechFilePath) async {
    // Play the audio file
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(UrlSource(speechFilePath));
  }

  int getCredits() {
    int credits = Random().nextInt(5);
    return credits;
  }
  // Navigation.. Not the best but kind of stuck with it for now
  void navToHomePage() {
    emit(const HomePageState());
  }

  Future<void> navToHomePageDelayed() async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(const HomePageState());
    });
  }

  void navToHowPage() {
    emit(const HowPageState());
  }

  void navToMoneyPage() {
    int credits = getCredits();
    print(credits);
    emit(MoneyPageState(credits));
  }



}