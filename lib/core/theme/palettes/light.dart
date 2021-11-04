import 'dart:ui';

import 'package:flutter/material.dart';

import '../convention.dart';
import 'color_palette.dart';

class LightPalette extends ColorPalette {
  @override
  Map<AppColor, Color> get paletteColors => {
        AppColor.accent: const Color(0xffFFC200),
        AppColor.background: const Color(0xfff9f9f9),
        AppColor.positive: const Color(0xff33CC66),
        AppColor.negative: const Color(0xffEC5766),
        AppColor.strong: const Color(0xff484848),
        AppColor.inactive: const Color(0xff93A8C6),
        AppColor.active: const Color(0xFF4FC3F7),
        AppColor.activeDark: const Color(0xff18417C),
        AppColor.activeLight: const Color(0xFFB3E5FC),
        AppColor.inactiveLight: const Color(0xFFE0E7EE)
      };

  @override
  Palette get type => Palette.light;
}
