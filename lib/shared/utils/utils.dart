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
}
