import 'package:tf_framework/models/base_model.dart';

enum FSProductCategory { electronics, jewelry, men_clothing, women_clothing }

categoryEnumFromString(String value) {
  switch (value) {
    case "electronics":
      return FSProductCategory.electronics;
    case "jewelery":
      return FSProductCategory.jewelry;
    case "men's clothing":
      return FSProductCategory.men_clothing;
    case "women's clothing":
      return FSProductCategory.women_clothing;
  }
}

stringFromProductCategory(FSProductCategory category) {
  switch (category) {
    case FSProductCategory.electronics:
      return "electronics";
    case FSProductCategory.jewelry:
      return "jewelery";
    case FSProductCategory.men_clothing:
      return "men's clothing";
    case FSProductCategory.women_clothing:
      return "women's clothing";
  }
}
