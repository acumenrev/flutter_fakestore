import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fakestore_core_foundation/network/api.dart';

void main() {
  group("test build api", () {
    /*
    * case _APICarts.getAllCarts:
        return _getAllCarts(data);
      case _APICarts.getUserCart:
        return _getUserCart(data);
      case _APICarts.getASingleCart:
        return _getASingleCart(data);
      case _APICarts.addProductToCart:
        return _addProductToCart(data);
      case _APICarts.updateProductInCart:
        return _updateProductInCart(data);
      case _APICarts.deleteProductFromCart:
        return _deleteProductInCart(data);
    * */
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
    });

    test("add product to cart", () {});
  });
}
