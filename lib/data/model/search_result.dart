

class AIResult {
  final String search;
  final String result;

  AIResult({required this.search, required this.result});


  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AIResult &&
        o.search == search &&
        o.result == result;
  }

  @override
  int get hashCode => search.hashCode ^ result.hashCode;
}