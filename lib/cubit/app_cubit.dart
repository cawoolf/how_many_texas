import 'package:bloc/bloc.dart';
import 'app_state.dart';
import 'package:how_many_texas/data/api_repository.dart';

class AppCubit extends Cubit<AppState> {
  final APIRepository _apiRepository;

  AppCubit(this._apiRepository) :super(const AppInitial());

  Future<void> apiRequests(String search) async {
    try {
      emit(const APILoading());
      final searchImage = await _apiRepository.fetchSearchImage(search);
      final aiResult = await _apiRepository.fetchAIResult(search);
      emit(APILoaded(searchImage, aiResult));
    } on APIError {
      emit(const APIError('Something went worng'));
    }
  }

}