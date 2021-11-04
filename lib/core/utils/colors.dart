import 'dart:math';
import 'dart:ui';

class ColorsUtils {
  static Color generateRandomFromStringSeed(String seed, [double opacity = 1]) {
    final random = Random(seed.codeUnits.reduce((value, element) => value + element));
    return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), opacity);
  }
}
