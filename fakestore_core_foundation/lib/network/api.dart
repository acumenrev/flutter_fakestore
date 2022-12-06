import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api_category.dart';
import 'package:fakestore_core_foundation/network/api_products.dart';
import 'package:tf_framework/models/base_model.dart';

import 'api_user.dart';

enum APICarts {
  getAllCarts,
  getUserCart,
  getASingleCart,
  addProductToCart,
  updateProductInCart,
  deleteProductFromCart
}

class API {
  String _baseUrl = "";
  static API shared = API();
  APICallCategories apiCallCategories = APICallCategories();
  APICallProducts apiProducts = APICallProducts();
  APICallUsers apiUsers = APICallUsers();
  API() {
    _baseUrl = "https://fakestoreapi.com";
  }

  Uri buildAPI({required String path, Map<String, dynamic>? queryParams}) {
    var uri = Uri(
        scheme: "https",
        host: _baseUrl,
        path: path,
        queryParameters: queryParams);

    return uri;
  }
}

// API on Carts
extension on API {
  Uri getCartsAPI(APICarts api, JSONData data) {
    switch (api) {
      case APICarts.getAllCarts:
        return _getAllCarts(data);
      case APICarts.getUserCart:
        return _getUserCart(data);
      case APICarts.getASingleCart:
        return _getASingleCart(data);
      case APICarts.addProductToCart:
        return _addProductToCart(data);
      case APICarts.updateProductInCart:
        return _updateProductInCart(data);
      case APICarts.deleteProductFromCart:
        return _deleteProductInCart(data);
    }
  }

  _getAllCarts(JSONData data) {
    return buildAPI(path: "/carts", queryParams: data);
  }

  _getUserCart(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/carts/user/${userId}");
  }

  _getASingleCart(JSONData data) {
    int cartId = data["cartId"] ?? 0;
    return buildAPI(path: "/carts/${cartId}");
  }

  _addProductToCart(JSONData data) {
    return buildAPI(path: "/carts");
  }

  _updateProductInCart(JSONData data) {
    int cartId = data["cartId"] ?? 0;
    return buildAPI(path: "carts/${cartId}");
  }

  _deleteProductInCart(JSONData data) {
    int cartId = data["cartId"] ?? 0;
    return buildAPI(path: "carts/${cartId}");
  }
}
