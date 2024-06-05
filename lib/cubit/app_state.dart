import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:how_many_texas/data/model/search_result.dart';

import '../data/model/search_image.dart';

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
  // final SearchImage searchImage;
  // final AIResult aiResult;
  // const APILoaded(this.searchImage, this.aiResult);
  const APILoaded();
}

class APIError extends AppState {
  final String message;
  const APIError(this.message);

  // Still not sure about what this is for..
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is APIError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
