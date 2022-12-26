enum AppFonts { Roboto, Rubik_Gemstones }

enum AppFontStyle {
  Regular,
  Thin,
  Thin_Italic,
  Medium_Italic,
  Medium,
  Light_Italic,
  Light,
  Italic,
  Bold_Italic,
  Bold,
  Black_Italic,
  Black
}

class FontConstants {
  static String getFont({required AppFonts fontName}) {
    switch (fontName) {
      case AppFonts.Roboto:
        return "Roboto";
      case AppFonts.Rubik_Gemstones:
        return "Rubik Gemstones";
    }
  }
}
