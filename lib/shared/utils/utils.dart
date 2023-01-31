import 'dart:math';

class Utils {
  static int getRandomInt(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min);
  }
}
