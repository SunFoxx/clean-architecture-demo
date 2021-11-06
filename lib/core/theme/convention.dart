import 'dart:ui';

import 'colors.dart';
import 'theme.dart';

/// set of strict rules that are affecting UI colors and sizes across the app
/// could be the singleton, but it doesn't need a lazy initialization
class StyleConvention {
  static final AppColors _appColors = AppTheme.colors;

  /// font size mapping for local naming convention
  static const Map<FontSize, double> _fontSizes = {
    FontSize.tiny: 8.0,
    FontSize.small: 12.0,
    FontSize.base: 14.0,
    FontSize.increased: 16.0,
    FontSize.major: 18,
    FontSize.big: 20.0,
    FontSize.large: 22.0,
    FontSize.huge: 30.0,
  };

  /// font color mapping for local naming convention
  static final Map<FontColor, Color> _fontColors = {
    FontColor.primary: _appColors.textRegular,
    FontColor.backgrounded: _appColors.textBackgrounded,
    FontColor.weak: _appColors.textWeak,
    FontColor.weakBackgrounded: _appColors.textWeakBackgrounded,
    FontColor.accent: _appColors.textAccent,
    FontColor.negative: _appColors.textNegative,
    FontColor.positive: _appColors.textPositive,
    FontColor.active: _appColors.textActive,
  };

  /// extract size from enum value [FontSize] multiplied by [fontScaleFactor]
  static double pickFontSize(FontSize size) => _fontSizes[size] ?? 14.0;

  /// extract color from enum value [FontColor]
  static Color pickFontColor(FontColor color) => _fontColors[color] ?? _appColors.textRegular;
}

enum FontSize {
  tiny,
  small,
  base,
  increased,
  major,
  big,
  large,
  huge,
}

enum FontColor {
  primary,
  backgrounded,
  focused,
  weak,
  weakBackgrounded,
  accent,
  negative,
  positive,
  active
}

enum AppColor {
  background,
  positive,
  negative,
  accent,
  strong,
  active,
  activeLight,
  activeDark,
  inactive,
  inactiveLight
}
