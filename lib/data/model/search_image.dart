
import 'package:flutter/widgets.dart';

class SearchImage {
  final String search;
  final Image image;

  SearchImage({required this.search, required this.image});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchImage &&
        o.search == search &&
        o.image == image;
  }

  @override
  int get hashCode => search.hashCode ^ image.hashCode;
}