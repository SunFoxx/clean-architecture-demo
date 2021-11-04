import 'package:flutter/material.dart';

import '../convention.dart';

/// core set of colors for the entire app
abstract class ColorPalette {
  Palette get type;

  Map<AppColor, Color> get paletteColors;

  Color pick(AppColor appColor) => paletteColors[appColor] ?? const Color(0x00ffffff);
}

/// specify more color palettes here
enum Palette {
  light,
}
