
import 'model/search_image.dart';
import 'model/search_result.dart';

abstract class APIRepository {
  // Throws [Network Exception]
  Future<SearchImage> fetchSearchImage(String search);
  Future<AIResult> fetchAIResult(String search);

}

class TestAPIRepository implements APIRepository {
  @override
  Future<AIResult> fetchAIResult(String search) {
    // TODO: implement fetchMLResult
    throw UnimplementedError();
  }

  @override
  Future<SearchImage> fetchSearchImage(String search) {
    // TODO: implement fetchSearchImage
    throw UnimplementedError();
  }

}