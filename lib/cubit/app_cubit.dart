import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:how_many_texas/constants/constants.dart';
import 'package:how_many_texas/data/model/search_image.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/utils/texas_calculator.dart';
import 'app_state.dart';
import 'package:how_many_texas/utils/api_service.dart';

class AppCubit extends Cubit<AppState> {
  final APIService _apiRepository;

  AppCubit(this._apiRepository) :super(const WelcomePageState());

  Future<void> welcomePageDelay() async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(const HomePageState());
    });
  }

  Future<void> apiRequests(String userInput) async {
    try {
      emit(const APILoadingState());
      final searchImageURL = await _apiRepository.fetchSearchImage(userInput); // Calls the UnSplash AIP to return a random image of the user input
      final searchImage = SearchImage(search: userInput, image: _loadImage(searchImageURL));

      final objectDimensions = await _apiRepository.fetchChatCompletion(userInput, GPT_PROMPT); // Calls OpenAI API to return the dimensions of the object the user inputs to the search field
      final numberWords = await _apiRepository.fetchChatCompletion(calculateHowManyTexas(objectDimensions), TTS_PROMPT); // Calculates how many times the object fits into Texas, and then calls the API to return the number in written english.
      final String fullText = "${numberWords.result} $userInput can fit inside of Texas";
      final ttsFilePath = await _apiRepository.fetchChatTTS(fullText); // Submits the result of the numberWords to the OpenAI TTS API to generate an audio file, and store it to the file path, and returns the file path

      emit(APILoaded(searchImage, objectDimensions, ttsFilePath));

    } catch (error) {

      log("apiRequest error: $error");
      emit(APIError(error.toString()));
    }
  }

  void loadHomePage() {
    emit(const HomePageState());
  }

  Image _loadImage(String? searchImageURL) {
    return Image.network(searchImageURL!);
  }

  String calculateHowManyTexas(AIResult aiResult) {
    TexasCalculator texasCalculator = TexasCalculator();
    return texasCalculator.calculateFromAPIResult(aiResult.result);
  }

  // String getNumberWords(AIResult aiResult) {
  //   TexasCalculator texasCalculator = TexasCalculator();
  //   return texasCalculator.getNumberWords(aiResult.result);
  // }

  Future<void> playNumbersAudio(String speechFilePath) async {
    // Play the audio file
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(UrlSource(speechFilePath));
  }

}