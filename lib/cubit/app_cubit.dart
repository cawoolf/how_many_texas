import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:how_many_texas/constants/constants.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/utils/texas_calculator.dart';
import 'app_state.dart';
import 'package:how_many_texas/utils/api_service.dart';

class AppCubit extends Cubit<AppState> {
  final APIService _apiRepository;
  late SearchResult _searchResult;

  AppCubit(this._apiRepository) :super(const WelcomePageState());

  Future<void> apiRequests(String userInput) async {
    try {
      emit(const APILoadingState());

      final searchImageURL = await _apiRepository.fetchSearchImage(userInput); // Calls the UnSplash AIP to return a random image of the user input
      Image searchImage = await _loadImage(searchImageURL); // Loads the image provided by the URL

      final objectDimensions = await _apiRepository.fetchChatCompletion(userInput, GPT_PROMPT); // Calls OpenAI API to return the dimensions of the object the user inputs to the search field
      final finalNumberResult = calculateHowManyTexas(objectDimensions); // Calculates how many times the object can fit inside of Texas

      final finalNumberResultToWords = await _apiRepository.fetchChatCompletion(finalNumberResult, TTS_PROMPT); // Calculates how many times the object fits into Texas, and then calls the API to return the number in written english.
      final String fullText = "$finalNumberResultToWords $userInput can fit inside of Texas"; // Full text to be converted to audio
      final ttsFilePath = await _apiRepository.fetchChatTTS(fullText); // Submits the result of the finalNumberToWords to the OpenAI TTS API to generate an audio file, and store it to the file path, and returns the file path


      _searchResult = SearchResult(search: userInput,searchImage: searchImage, objectDimensionsResult: objectDimensions, finalNumberResult: finalNumberResult, TTS_PATH: ttsFilePath);


      emit(APILoaded(_searchResult));

    } catch (error) {

      emit(APIError(error.toString()));
    }
  }

  Image _loadErrorImage() {
    return Image.asset(
      'assets/cow_skull_edited.png',
      fit: BoxFit.scaleDown,
    );
  }

  Future<Image> _loadImage(String? searchImageURL) async {

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
          return _loadErrorImage();
        },
      );
    } else {
      return _loadErrorImage();
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

  // Getters

  int getCredits() {
    int credits = Random().nextInt(5);
    return credits;
  }

  SearchResult getCurrentSearchResult() {
    return _searchResult;
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

  void navToMoneyPage(int credits) {
    emit(MoneyPageState(credits));
  }



}