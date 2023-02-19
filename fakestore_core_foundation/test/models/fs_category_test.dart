import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("fs_category_test", () {
    test("test all enums", () {
      expect(FSProductCategory.values.length, 5);
    });

    test("test categoryEnumFromString", () {
      expect(
          categoryEnumFromString("electronics") ==
              FSProductCategory.electronics,
          true);
      expect(categoryEnumFromString("jewelery") == FSProductCategory.jewelry,
          true);
      expect(
          categoryEnumFromString("men's clothing") ==
              FSProductCategory.men_clothing,
          true);
      expect(
          categoryEnumFromString("women's clothing") ==
              FSProductCategory.women_clothing,
          true);
      expect(categoryEnumFromString("") == FSProductCategory.unknown, true);
    });

    test("stringFromProductCategory", () {
      expect(stringFromProductCategory(FSProductCategory.electronics),
          "electronics");
      expect(stringFromProductCategory(FSProductCategory.unknown), "");
      expect(stringFromProductCategory(FSProductCategory.jewelry), "jewelery");
      expect(stringFromProductCategory(FSProductCategory.men_clothing),
          "men's clothing");
      expect(stringFromProductCategory(FSProductCategory.women_clothing),
          "women's clothing");
    });
  });
}
