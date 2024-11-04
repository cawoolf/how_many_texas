import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class SearchResult extends Equatable {
  final String search;
  final Image searchImage;
  final String objectDimensionsResult;
  final int finalNumberResult;
  final String finalNumberWordsResult;
  final String TTS_PATH;

  const SearchResult(
      {required this.search,
      required this.searchImage,
      required this.objectDimensionsResult,
      required this.finalNumberResult,
      required this.finalNumberWordsResult,
      required this.TTS_PATH});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
