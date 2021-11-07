import 'package:flutter/cupertino.dart';

import 'convention.dart';
import 'theme.dart';

/// App's font configurations
/// use "${fontWeight}${colorAlteration}${size}${otherModifiers}" pattern for naming
/// [fontWeight] naming is described here https://docs.microsoft.com/en-us/typography/opentype/spec/os2#usweightclass
/// may be omitted if regular [FontWeight.normal] used
/// [colorAlteration] stands for color variants that differs depending on background or UI role, [FontColor]
/// [size] describes size variation following the convention of [FontSize]
class AppTextStyles {
  // ~*~ regular weight variations ~*~
  TextStyle get normal => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: StyleConvention.pickFontColor(FontColor.primary),
        fontSize: StyleConvention.pickFontSize(FontSize.base),
        decoration: TextDecoration.none,
      );

  TextStyle get weakSmall => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: StyleConvention.pickFontColor(FontColor.weak),
        fontSize: StyleConvention.pickFontSize(FontSize.small),
        height: 1.5,
        decoration: TextDecoration.none,
      );

  TextStyle get backgrounded => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.normal,
        color: StyleConvention.pickFontColor(FontColor.backgrounded),
        fontSize: StyleConvention.pickFontSize(FontSize.base),
        decoration: TextDecoration.none,
      );

  // ~*~ medium weight variations ~*~
  TextStyle get medium => AppTheme.baseFont.copyWith(
        fontWeight: FontWeight.w500,
        color: StyleConvention.pickFontColor(FontColor.primary),
        fontSize: StyleConvention.pickFontSize(FontSize.base),
        decoration: TextDecoration.none,
      );

  TextStyle get mediumIncreasedActive => medium.copyWith(
        color: StyleConvention.pickFontColor(FontColor.active),
        fontSize: StyleConvention.pickFontSize(FontSize.increased),
      );

  TextStyle get mediumLargeDecorative => AppTheme.decorationFont.copyWith(
        fontSize: StyleConvention.pickFontSize(FontSize.large),
        fontWeight: FontWeight.w500,
        color: StyleConvention.pickFontColor(FontColor.primary),
      );

  // ~*~ semi-bold weight variations ~*~
  TextStyle get semibold => AppTheme.baseFont.copyWith(
        fontSize: StyleConvention.pickFontSize(FontSize.base),
        fontWeight: FontWeight.w600,
        color: StyleConvention.pickFontColor(FontColor.primary),
      );

  TextStyle get semiboldNegative =>
      semibold.copyWith(color: StyleConvention.pickFontColor(FontColor.negative));
}
