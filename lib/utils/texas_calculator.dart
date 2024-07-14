import 'dart:convert';

class TexasCalculator {
  static const double texasAreaSquareMiles = 268596.0;

  double _convertToSquareMiles(double value, String unit) {
    const double inchesToMiles = 1 / 63360.0; // 1 mile = 63,360 inches
    const double feetToMiles = 1 / 5280.0; // 1 mile = 5280 feet
    const double yardsToMiles = 1 / 1760.0; // 1 mile = 1760 yards

    switch (unit) {
      case 'inches':
        return value * inchesToMiles;
      case 'feet':
        return value * feetToMiles;
      case 'yards':
        return value * yardsToMiles;
      case 'miles':
        return value;
      default:
        throw ArgumentError('Unsupported unit: $unit');
    }
  }

  double _calculateObjectArea(Map<String, dynamic> json) {

    if(json['area'] != null) {
      return json['area'].toDouble();
    }

    double length = json['length'].toDouble();
    double width = json['width'].toDouble();
    String unit = json['unit'];

    double lengthInMiles = _convertToSquareMiles(length, unit);
    double widthInMiles = _convertToSquareMiles(width, unit);

    return lengthInMiles * widthInMiles;
  }

  double _calculateFitTimes(Map<String, dynamic> json) {
    double objectArea = _calculateObjectArea(json);
    return texasAreaSquareMiles / objectArea;
  }

  String calculateFromAPIResult(String result)  {
    Map<String, dynamic> json = jsonDecode(result);

    double fitTimes = _calculateFitTimes(json);

    print('The object fits inside Texas $fitTimes times.');

    return fitTimes.round().toString();
  }

}