

class AIResult {
  final String search;
  final String aiResult;

  AIResult({required this.search, required this.aiResult});


  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AIResult &&
        o.search == search &&
        o.aiResult == aiResult;
  }

  @override
  int get hashCode => search.hashCode ^ aiResult.hashCode;
}