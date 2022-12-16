import 'package:fakestore_core_foundation/models/fs_cart_product.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("fs_cart_product_test", () {
    test("init from valid json", () async {
      final productCart =
          FSCartProduct.fromJson({"productId": 1, "quantity": 4});
      expect(productCart != null, true);
      expect(productCart.productId, 1);
      expect(productCart.quantity, 4);
    });
    test("init from invalid json", () {
      final productCart = FSCartProduct.fromJson({"message": "ok"});
      expect(productCart != null, true);
      expect(productCart.productId, 0);
      expect(productCart.quantity, 0);
    });
    test("init from null json", () {
      final productCart = FSCartProduct.fromJson(null);
      expect(productCart != null, true);
      expect(productCart.productId, 0);
      expect(productCart.quantity, 0);
    });

    group("parse list json", () {
      test("init with empty aray", () {
        List<FSCartProduct> list = FSCartProduct.parseFromList(null);
        expect(list.isEmpty, true);
        List<FSCartProduct> list2 = FSCartProduct.parseFromList([]);
        expect(list.isEmpty, true);
      });

      test("init with aray", () {
        List<FSCartProduct> list = FSCartProduct.parseFromList([
          {"productId": 1, "quantity": 4},
          {"productId": 2, "quantity": 1},
          {"productId": 3, "quantity": 6}
        ]);
        expect(list.isEmpty, false);
        expect(list[0].productId, 1);
        expect(list[0].quantity, 4);
      });
    });
  });
}
