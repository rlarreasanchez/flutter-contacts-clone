import 'dart:developer';
import 'dart:math';

import 'package:diacritic/diacritic.dart';

class Utils {
  static int getRandomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }

  static bool containsStringTerm(String value, String term) {
    return removeDiacritics(value.toLowerCase())
        .contains(removeDiacritics(term.toLowerCase()));
  }

  static bool containsListTerm(List values, String term) {
    for (var value in values) {
      if (containsStringTerm(value, term)) {
        return true;
      }
    }

    return false;
  }

  static String stringListTerm(List values, String term) {
    for (var value in values) {
      if (containsStringTerm(value, term)) {
        return value;
      }
    }

    return '';
  }

  static String stringToPhoneNumber(String value) {
    String trimValue = value.replaceAll(' ', '');
    if (trimValue.length == 9) {
      return '${trimValue.substring(0, 3)} ${trimValue.substring(3, 5)} ${trimValue.substring(5, 7)} ${trimValue.substring(7, 9)}';
    }
    if (value.length == 12) {
      return '${trimValue.substring(0, 3)} ${trimValue.substring(3, 6)} ${trimValue.substring(6, 8)} ${trimValue.substring(8, 10)} ${trimValue.substring(10, 12)}';
    }
    return trimValue;
  }
}
