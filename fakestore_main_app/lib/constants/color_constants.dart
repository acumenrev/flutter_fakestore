import 'package:flutter/material.dart';

class ColorConstants {
  static Color colorFromHex(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color colorE30404 = colorFromHex('#E30404');
  static Color colorF7F7F7 = colorFromHex('#F7F7F7');
  static Color colorF8F8F8 = colorFromHex("#F8F8F8");
}
