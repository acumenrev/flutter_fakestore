import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_cart.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("fs_cart_test", () {
    test("init from valid json", () async {
      String mockedPath = "test/json/carts/get_single_cart.json";
      String data = await FSCoreUtils.loadJsonFile(mockedPath);
      final cart = FSCart.fromJson(jsonDecode(data));
      expect(cart != null, true);
      expect(cart.id, 5);
      expect(cart.userId, 3);
      expect(cart.date, "2020-03-01T00:00:02.000Z");
      expect(cart.products.isNotEmpty, true);
      expect(cart.products.length, 2);
    });
    test("init from invalid json", () {
      final cart = FSCart.fromJson({"message": "ok"});
      expect(cart != null, true);
      expect(cart.id, 0);
      expect(cart.userId, 0);
      expect(cart.date, "");
      expect(cart.products.length, 0);
    });
    test("init from null json", () {
      final cart = FSCart.fromJson(null);
      expect(cart != null, true);
      expect(cart.id, 0);
      expect(cart.userId, 0);
      expect(cart.date, "");
      expect(cart.products.length, 0);
    });

    group("parse list json", () {
      test("init with empty aray", () {
        List<FSCart> list = FSCart.parseFromList(null);
        expect(list.isEmpty, true);
        List<FSCart> list2 = FSCart.parseFromList([]);
        expect(list.isEmpty, true);
      });

      test("init with aray", () async {
        String mockedPath = "test/json/carts/get_all_carts.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));

        List<FSCart> list = FSCart.parseFromList(listJson);
        expect(list.isEmpty, false);
        expect(list.length, 7);
      });
    });
  });
}
