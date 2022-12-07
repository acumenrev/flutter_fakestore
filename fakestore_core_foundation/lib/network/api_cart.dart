import 'package:fakestore_core_foundation/models/fs_cart.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

import '../models/fs_cart_product.dart';
import 'api.dart';

enum APICarts {
  getAllCarts,
  getUserCart,
  getASingleCart,
  addProductToCart,
  updateProductInCart,
  deleteProductFromCart
}

typedef QueryParams = Map<String, String>;

// API on Carts
extension APIExtensionCarts on API {
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
    return buildAPI(
        path: "/carts",
        queryParams: API.shared.convertMapStringDynamicToMapStringString(data));
  }

  _getUserCart(JSONData data) {
    int userId = data["userId"] ?? 0;
    QueryParams params = {
      "limit": data["limit"] ?? 5,
      "sort": data["sort"] ?? "desc"
    }
    return buildAPI(path: "/carts/user/${userId}", queryParams: params);
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

class APICallCarts {
  /**
   * switch (api) {
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
   */

  /// Get All Carts
  getAllCarts(
      {int limit = 5,
      String sort = "desc",
      required String startDate,
      required String endDate}) async {
    List<FSCart> list = [];
    Uri url = API.shared.getCartsAPI(APICarts.getAllCarts, {
      "limit": limit,
      "sort": sort,
      "startdate": startDate,
      "enddate": endDate
    });
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    list.addAll(FSCart.parseFromList(response.getResponse().data));
    return list;
  }

  getUserCarts({int limit = 5, String sort = "desc", required int userId}) async {
    List<FSCart> list = [];
    Uri url = API.shared
        .getCartsAPI(APICarts.getUserCart, {"limit": limit, "sort": sort});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    list.addAll(FSCart.parseFromList(response.getResponse().data));
    return list;
  }

  getSingleCart(int cartId) async {
    Uri url = API.shared
        .getCartsAPI(APICarts.getASingleCart, {"cartId": cartId});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    FSCart cart = FSCart.fromJson(response.getResponse().data);
    return cart;
  }

  addProductsToCart(FSCart cart) async {
    Uri url = API.shared
        .getCartsAPI(APICarts.addProductToCart, {});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    FSCart result = FSCart.fromJson(response.getResponse().data);
    return result;
  }
}
