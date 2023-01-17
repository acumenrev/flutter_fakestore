// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("fs_product_test", () {
    test("init from valid json", () async {
      String mockedDataPath = "test/json/products/get_single_product.json";
      String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
      final list = FSProduct.fromJson(jsonDecode(data));
      expect(list != null, true);
      expect(list.id, 1);
      expect(
          list.title,
          "Fjallraven - Foldsack No. 1 Backpack, Fits 15 "
          "Laptops");
      expect(list.price, 109.95);
      expect(
          list.description,
          "Your perfect pack for everyday use and "
          "walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
      expect(list.category == FSProductCategory.men_clothing, true);
      expect(list.image,
          "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
      expect(list.rating != null, true);
      expect(list.rating?.count, 120);
      expect(list.rating?.rate, 3.9);
    });
    test("init from invalid json", () {
      final FSProduct list = FSProduct.fromJson({"message": "ok"});
      expect(list != null, true);
      expect(list.id, 0);
      expect(list.title, "");
      expect(list.price, 0);
      expect(list.description, "");
      expect(list.category == FSProductCategory.unknown, true);
      expect(list.image, "");
      expect(list.rating == null, true);
    });
    test("init from null json", () {
      final FSProduct list = FSProduct.fromJson(null);
      expect(list != null, true);
      expect(list.id, 0);
      expect(list.title, "");
      expect(list.price, 0);
      expect(list.description, "");
      expect(list.category == FSProductCategory.unknown, true);
      expect(list.image, "");
      expect(list.rating == null, true);
    });
    group("parse list json", () {
      test("init with empty aray", () {
        List<FSProduct> list = FSProduct.parseFromList(null);
        expect(list.isEmpty, true);
        List<FSProduct> list2 = FSProduct.parseFromList([]);
        expect(list.isEmpty, true);
      });

      test("init with aray", () async {
        String mockedPath = "test/json/products/get_all_products.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));

        List<FSProduct> list = FSProduct.parseFromList(listJson);
        expect(list.isEmpty, false);
        expect(list.length, 20);
      });
    });
  });
}
