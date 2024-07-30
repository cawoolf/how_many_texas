
import 'package:flutter/foundation.dart';
import 'package:how_many_texas/data/model/search_result.dart';
import '../data/model/search_image.dart';

// Needs to extends Equatable
@immutable
abstract class AppState {
  const AppState();
}

class WelcomePageState extends AppState {
  const WelcomePageState();
}

class HomePageState extends AppState {
  const HomePageState();
}

class APILoadingState extends AppState {
  const APILoadingState();
}

class APILoaded extends AppState {
  final SearchImage searchImage;
  final AIResult aiResult;
  final String ttsFilePath;
  const APILoaded(this.searchImage, this.aiResult, this.ttsFilePath);

}

class APIError extends AppState {
  final String errorMessage;
  const APIError(this.errorMessage);

  // Still not sure about what this is for..
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is APIError && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
