import 'package:fakestore_core_foundation/models/fs_cart.dart';
import 'package:fakestore_core_foundation/network/api_call.dart';
import 'package:flutter/cupertino.dart';
import 'package:tf_framework/models/base_error.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';
import 'package:tuple/tuple.dart';

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
extension APIExtensionCarts on NetworkModule {
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
    int limit = data["limit"] ?? 0;
    String sort = data["sort"] ?? "";
    String startDate = data["startdate"] ?? "";
    String endDate = data["enddate"] ?? "";
    QueryParams params = {};
    if (limit > 0) {
      params["limit"] = limit.toString();
    }
    if (sort.isNotEmpty) {
      params["sort"] = sort;
    }

    if (startDate.isNotEmpty) {
      params["startdate"] = startDate;
    }
    if (endDate.isNotEmpty) {
      params["enddate"] = endDate;
    }
    return buildAPI(path: "/carts", queryParams: params);
  }

  _getUserCart(JSONData data) {
    int userId = data["userId"] ?? 0;
    int limit = data["limit"] ?? 0;
    String sort = data["sort"] ?? "";

    QueryParams params = {};
    if (limit > 0) {
      params["limit"] = limit.toString();
    }
    if (sort.isNotEmpty) {
      params["sort"] = sort;
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

class APICallCarts extends APICall {
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
  Future<JSONData> getAllCarts(
      {int limit = 0,
      String sort = "",
      String startDate = "",
      String endDate = ""}) async {
    List<FSCart> list = [];

    Uri url = NetworkModule.shared.getCartsAPI(APICarts.getAllCarts, {
      "limit": limit,
      "sort": sort,
      "startdate": startDate,
      "enddate": endDate
    });
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);

    var decodedResponse = response.getDecodedJsonResponse();
    if (decodedResponse is List<dynamic>) {
      List<JSONData> listJson = List<JSONData>.from(decodedResponse);
      list.addAll(FSCart.parseFromList(listJson));
    }
    return generateNetworkResponse(list, response.getError());
  }

  /// Get carts for a user
  Future<JSONData> getUserCarts(
      {int limit = 5, String sort = "desc", required int userId}) async {
    List<FSCart> list = [];
    Uri url = NetworkModule.shared.getCartsAPI(
        APICarts.getUserCart, {"limit": limit, "sort": sort, "userId": userId});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    var decodedResponse = response.getDecodedJsonResponse();
    if (decodedResponse is List<dynamic>) {
      List<JSONData> listJson = List<JSONData>.from(decodedResponse);
      list.addAll(FSCart.parseFromList(listJson));
    }

    return generateNetworkResponse(list, response.getError());
  }

  /// Get a single cart information
  Future<JSONData> getSingleCart(int cartId) async {
    Uri url = NetworkModule.shared
        .getCartsAPI(APICarts.getASingleCart, {"cartId": cartId});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    FSCart cart = FSCart.fromJson(response.getDecodedJsonResponse());
    return generateNetworkResponse(cart, response.getError());
  }

  /// Add products to a cart
  Future<JSONData> addProductsToCart(FSCart cart) async {
    Uri url = NetworkModule.shared.getCartsAPI(APICarts.addProductToCart, {});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    FSCart result = FSCart.fromJson(response.getDecodedJsonResponse());
    return generateNetworkResponse(result, response.getError());
  }

  /// Update prodcts in a cart
  Future<JSONData> updateProductsInCart(FSCart cart) async {
    Uri url = NetworkModule.shared
        .getCartsAPI(APICarts.updateProductInCart, {"cartId": cart.id});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.put,
            data: cart.toJson());
    FSCart result = FSCart.fromJson(response.getDecodedJsonResponse());
    return generateNetworkResponse(result, response.getError());
  }

  /// Delete products in cart
  Future<JSONData> deleteProductsInCart(FSCart cart) async {
    Uri url = NetworkModule.shared
        .getCartsAPI(APICarts.deleteProductFromCart, {"cartId": cart.id});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.delete,
            data: cart.toJson());
    FSCart result = FSCart.fromJson(response.getDecodedJsonResponse());
    return generateNetworkResponse(result, response.getError());
  }
}
