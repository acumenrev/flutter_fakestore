import 'package:fakestore_main_app/constants/font_constants.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeManager shared = ThemeManager._();
  late ThemeData _currentSelectedThemeData;

  ThemeManager._() {
    _currentSelectedThemeData = ThemeData(
        fontFamily: FontConstants.getFont(fontName: AppFonts.roboto),
        useMaterial3: true);
  }

  getCurrentTheme() {
    return _currentSelectedThemeData;
  }
}
