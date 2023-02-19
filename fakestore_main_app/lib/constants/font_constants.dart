enum AppFonts { roboto, rubikGemstones }

enum AppFontStyle {
  regular,
  thin,
  thinItalic,
  mediumItalic,
  medium,
  lightItalic,
  light,
  italic,
  boldItalic,
  bold,
  blackItalic,
  black
}

class FontConstants {
  static String getFont({required AppFonts fontName}) {
    switch (fontName) {
      case AppFonts.roboto:
        return "Roboto";
      case AppFonts.rubikGemstones:
        return "Rubik Gemstones";
    }
  }
}
