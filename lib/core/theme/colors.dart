import 'package:flutter/cupertino.dart';

import 'convention.dart';
import 'palettes/color_palette.dart';

/// semantically separated colors that are referencing [AppPalette] as the source for colors
/// used directly inside the widgets
class AppColors {
  final ColorPalette palette;

  AppColors({required this.palette});

  // ~*~ single colors ~*~
  Color get backgroundMain => palette.pick(AppColor.background);
  Color get backgroundActive => palette.pick(AppColor.active);

  Color get shadowColor => palette.pick(AppColor.strong).withOpacity(0.2);

  Color get inactiveButtonStrongColor => palette.pick(AppColor.inactiveLight);
  Color get inactiveButtonTextColor => palette.pick(AppColor.inactive);
  Color get activeButtonTextColor => palette.pick(AppColor.active);
  Color get activeButtonStrongColor => palette.pick(AppColor.accent);
  Color get scrollButtonBackgroundColor => palette.pick(AppColor.activeLight);

  Color get dividerColor => palette.pick(AppColor.inactiveLight);

  Color get positiveIconColor => palette.pick(AppColor.positive);
  Color get negativeIconColor => palette.pick(AppColor.negative);

  Color get transparent => const Color(0x00ffffff);

  // ~*~ Text colors ~*~
  Color get textBackgrounded => palette.pick(AppColor.background);

  Color get textRegular => palette.pick(AppColor.strong);

  Color get textWeak => palette.pick(AppColor.inactive);

  Color get textWeakBackgrounded => palette.pick(AppColor.background).withOpacity(0.75);

  Color get textAccent => palette.pick(AppColor.accent);

  Color get textNegative => palette.pick(AppColor.negative);

  Color get textPositive => palette.pick(AppColor.positive);

  Color get textActive => palette.pick(AppColor.active);
}
