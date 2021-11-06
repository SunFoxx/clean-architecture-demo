import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'palettes/color_palette.dart';
import 'palettes/light.dart';
import 'typografy.dart';

/// Access point for all styling parameters
/// Connects together all theme parts - text styles, sizes and colors
/// Doesn't need a [BuildContext] to work, but needs to be listened in the root widget
/// Basically, a singleton object. For easier access of instance, it uses static methods
class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._();

  factory AppTheme() => _instance;

  AppTheme._() {
    _palette = LightPalette();
    _typography = AppTextStyles();
  }

  late ColorPalette _palette;
  late AppTextStyles _typography;

  static ColorPalette get palette => _instance._palette;
  static AppTextStyles get typography => _instance._typography;
  static AppColors get colors => AppColors(palette: palette);

  static TextStyle baseFont = GoogleFonts.poppins();
  static TextStyle decorationFont = GoogleFonts.cinzelDecorative();

  void changePalette(Palette palette) {
    switch (palette) {
      case Palette.light:
        _palette = LightPalette();
        break;
    }
    notifyListeners();
  }
}
