import 'dart:ui';

import 'package:flutter/material.dart';

import '../convention.dart';
import 'color_palette.dart';

class LightPalette extends ColorPalette {
  @override
  Map<AppColor, Color> get paletteColors => const {
        AppColor.accent: Color(0xffFFC200),
        AppColor.background: Color(0xfff9f9f9),
        AppColor.positive: Color(0xff33CC66),
        AppColor.negative: Color(0xffEC5766),
        AppColor.strong: Color(0xff484848),
        AppColor.inactive: Color(0xff93A8C6),
        AppColor.active: Color(0xFF4FC3F7),
        AppColor.activeDark: Color(0xff18417C),
        AppColor.activeLight: Color(0xFFB3E5FC),
        AppColor.inactiveLight: Color(0xFFE0E7EE)
      };

  @override
  Palette get type => Palette.light;
}
