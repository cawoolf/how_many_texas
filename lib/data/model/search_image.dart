
import 'dart:ui';

class SearchImage {
  final String search;
  final Image searchImage;

  SearchImage({required this.search, required this.searchImage});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SearchImage &&
        o.search == search &&
        o.searchImage == searchImage;
  }

  @override
  int get hashCode => search.hashCode ^ searchImage.hashCode;
}