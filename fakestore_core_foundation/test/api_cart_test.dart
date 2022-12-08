import 'package:fakestore_core_foundation/models/fs_cart.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fakestore_core_foundation/network/api.dart';

void main() {
  group("test build api", () {
    test("get all cart", () {
      Uri url = API.shared.getCartsAPI(APICarts.getAllCarts, {});
      String expectedResult = "https://fakestoreapi.com/carts";
      expect(url.toString(), expectedResult);
    });

    test("get user cart", () {
      Uri url = API.shared.getCartsAPI(APICarts.getUserCart, {"userId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/user/1";
      expect(url.toString(), expectedResult);
    });
    test("get a single cart", () {
      Uri url = API.shared.getCartsAPI(APICarts.getASingleCart, {"cartId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/1";
      expect(url.toString(), expectedResult);
    });

    test("add product to cart", () {
      Uri url = API.shared.getCartsAPI(APICarts.addProductToCart, {});
      String expectedResult = "https://fakestoreapi.com/carts";
      expect(url.toString(), expectedResult);
    });

    test("update product to cart", () {
      Uri url =
          API.shared.getCartsAPI(APICarts.updateProductInCart, {"cartId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/1";
      expect(url.toString(), expectedResult);
    });

    test("update product to cart with incorrect params", () {
      Uri url = API.shared
          .getCartsAPI(APICarts.updateProductInCart, {"incorrect_params": 1});
      String expectedResult = "https://fakestoreapi.com/carts/0";
      expect(url.toString(), expectedResult);
    });

    test("delete product from cart", () {
      Uri url =
          API.shared.getCartsAPI(APICarts.deleteProductFromCart, {"cartId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/1";
      expect(url.toString(), expectedResult);
    });
  });
  group("test call api", () {
    group("get all carts", () {
      test("success", () async {
        List<FSCart> list = await API.shared.apiCarts.getAllCarts();
        expect(list.isEmpty, false);
      });
    });
  });
}
