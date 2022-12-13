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
  });
}
