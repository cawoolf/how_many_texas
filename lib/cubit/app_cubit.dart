import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:how_many_texas/data/model/search_image.dart';
import 'app_state.dart';
import 'package:how_many_texas/data/api_repository.dart';

class AppCubit extends Cubit<AppState> {
  final APIRepository _apiRepository;

  AppCubit(this._apiRepository) :super(const WelcomePageState());

  Future<void> welcomePageDelay() async {
    Future.delayed(const Duration(seconds: 3), () {
      emit(const HomePageState());
    });
  }

  Future<void> apiRequests(String search) async {
    try {
      emit(const APILoadingState());
      final searchImageURL = await _apiRepository.fetchSearchImage(search);
      final searchImage = SearchImage(search: search, image: _loadImage(searchImageURL));

      final aiResult = await _apiRepository.fetchAIResult(search);

      emit(APILoaded(searchImage, aiResult));

    } on APIError {

      emit(const APIError('Something went wrong'));
    }
  }

  void loadHomePage() {
    emit(const HomePageState());
  }

  Image _loadImage(String? searchImageURL) {
    return Image.network(searchImageURL!);
  }

}