import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:how_many_texas/constants/constants.dart';
import 'package:how_many_texas/cubit/purchase_service.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import 'package:how_many_texas/cubit/texas_calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_state.dart';
import 'package:how_many_texas/cubit/api_service.dart';

class AppCubit extends Cubit<WorkingAppState> {
  final APIService _apiRepository;
  late SearchResult _searchResult;
  AudioPlayer? _audioPlayer;
  bool? _creditsInitialized;
  int _credits = 0; // default value

  AppCubit(this._apiRepository) : super(const WelcomePageState());

  // Getters
  int getCredits() {
    return _credits;
  }

  SearchResult getCurrentSearchResult() {
    return _searchResult;
  }

  // Setters
  Future<void> setCredits(int credits) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(CREDITS, credits);
    _credits = await _loadCredits();
    if (_credits != credits) {
      print('app_cubit.dart line 37 -> SET CREDIT ERROR');
      emit(const APIError('setCredits Error'));
    }
  }

  Future<int> _loadCredits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _credits = prefs.getInt(CREDITS)!;
    return _credits;
  }

  // Helper Methods
  int calculateHowManyTexas(String objectDimensions) {
    TexasCalculator texasCalculator = TexasCalculator();
    return texasCalculator.calculateFitTimesFromAPIResult(objectDimensions);
  }

  Future<void> playNumbersAudio(String speechFilePath) async {
    // If an audio is already playing, stop it
    if (_audioPlayer != null) {
      await _audioPlayer!.stop();
    }

    // Create or reuse the audio player instance
    _audioPlayer ??= AudioPlayer();

    // Play the audio file
    await _audioPlayer!.play(UrlSource(speechFilePath));
  }

  Image _loadErrorImage() {
    return Image.asset(
      'assets/cow_skull_edited.png',
      fit: BoxFit.scaleDown,
    );
  }

  // API Calls
  Future<void> apiRequests(String userInput) async {
    try {
      emit(const APILoadingState());

      final searchImageURL = await _apiRepository.fetchSearchImage(
          userInput); // Calls the UnSplash AIP to return a random image of the user input
      Image searchImage = await _loadImage(
          searchImageURL); // Loads the image provided by the URL

      final objectDimensions = await _apiRepository.fetchChatCompletion(
          userInput,
          GPT_PROMPT); // Calls OpenAI API to return the dimensions of the object the user inputs to the search field
      final finalNumberResult = calculateHowManyTexas(
          objectDimensions); // Calculates how many times the object can fit inside of Texas

      final finalNumberResultToWords = await _apiRepository.fetchChatCompletion(
          finalNumberResult.toString(),
          TTS_PROMPT); // Calculates how many times the object fits into Texas, and then calls the API to return the number in written english.
      final String fullText =
          "$finalNumberResultToWords $userInput can fit inside of Texas"; // Full text to be converted to audio
      final ttsFilePath = await _apiRepository.fetchChatTTS(
          fullText); // Submits the result of the finalNumberToWords to the OpenAI TTS API to generate an audio file, and store it to the file path, and returns the file path

      _searchResult = SearchResult(
          search: userInput,
          searchImage: searchImage,
          objectDimensionsResult: objectDimensions,
          finalNumberResult: finalNumberResult,
          finalNumberWordsResult: finalNumberResultToWords,
          TTS_PATH: ttsFilePath);

      _credits--;
      print('credit_spent $_credits');

      setCredits(_credits);
      emit(const APILoaded());
    } catch (error) {
      emit(APIError(error.toString()));
    }
  }

  Future<Image> _loadImage(String? searchImageURL) async {
    if (searchImageURL != null) {
      return Image.network(
        searchImageURL,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return _loadErrorImage();
        },
      );
    } else {
      return _loadErrorImage();
    }
  }

  // Navigation.. Not the best but kind of stuck with it for now
  void navToHomePage() {
    emit(const HomePageState());
  }

  void navToResponsePage() {
    emit(const APILoaded());
  }

  void navToHowPage() {
    emit(const HowPageState());
  }

  Future<void> navToHomePageDelayed() async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(const HomePageState());
    });
  }

  void navToMoneyPage() {
    emit(MoneyPageState());
  }

  Future<void> navToMoneyPageDelayed(int credits) async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(MoneyPageState());
    });
  }

  void buyCredits() async {
    await setCredits(50);
    navToHomePage();
  }

  void creditInitialization() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _creditsInitialized = prefs.getBool(CREDITS_ACTIVE);
      print('credits_intizilied $_creditsInitialized');
      if (_creditsInitialized == null) {
        prefs.setBool(CREDITS_ACTIVE, true);
        prefs.setInt(CREDITS, 1); // Initial credits on install
        _credits = await _loadCredits();
        print('credits_intizlized $_credits');
      } else {
        _credits = await _loadCredits();
        print('credits_already $_credits');
      }
    } catch (error) {
      emit(const APIError('credit initialization error'));
    }
  }

  Future<bool> creditCheck() async {
    _credits = await _loadCredits();
    if (_credits <= 0) {
      return false;
    } else {
      return true;
    }
  }

  void checkCreditsAndNavToCorrectPage() async {
    bool enoughCredits = await creditCheck();
    if (enoughCredits) {
      navToHomePage();
    } else {
      navToMoneyPage();
    }
  }

  void loadInterstitialAd() {
    emit(const APILoadingState());
    String testAdId = 'ca-app-pub-3940256099942544/1033173712';
    InterstitialAd? interstitialAd;

    InterstitialAd.load(
      adUnitId: testAdId, // Test Ad Unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          interstitialAd!.setImmersiveMode(true);

          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) async {
              // Navigate to the second page when the ad is closed
              await setCredits(4);
              navToHomePage();
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              emit(APIError('Ad failed to show: $error'));
              ad.dispose();
            },
          );

          _showInterstitialAd(interstitialAd);
        },
        onAdFailedToLoad: (LoadAdError error) {
          emit(APIError('InterstitialAd failed to load: $error'));
        },
      ),
    );
  }

  void _showInterstitialAd(InterstitialAd? interstitialAd) {
    if (interstitialAd != null) {
      interstitialAd.show();
      interstitialAd = null; // Reset the ad instance after showing
      // loadInterstitialAd(); // Load a new ad for the next time
    } else {
      emit(const APIError(
          'InterstitialAd failed to load: _showInterstitialAd()'));
    }
  }

  void setLoadingState() {
    emit(const APILoadingState());
  }

  void setErrorState(String errorMessage) {
    emit(APIError(errorMessage));
  }
}
