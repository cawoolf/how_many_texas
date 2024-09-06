
// Capitalize the first letter of a String
import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

// Adds place holder commas to a large integer
String formatWithCommas(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}
