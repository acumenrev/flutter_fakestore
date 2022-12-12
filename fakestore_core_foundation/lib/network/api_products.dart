import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

enum APIProducts {
  getProducts,
  getSingleProduct,
  addProduct,
  updateProduct,
  deleteProduct
}

/// API For Products
extension APIExtensionProducts on NetworkModule {
  Uri getProductAPI(APIProducts api, JSONData data) {
    switch (api) {
      case APIProducts.getProducts:
        return _getProducts(data);
      case APIProducts.getSingleProduct:
        return _getSingleProduct(data);
      case APIProducts.addProduct:
        return _addProduct(data);
      case APIProducts.updateProduct:
        return _updateProduct(data);
      case APIProducts.deleteProduct:
        return _deleteProduct(data);
    }
  }

  _getProducts(JSONData data) {
    int limit = data["limit"] ?? 20;
    int offset = data["offset"] ?? 0;
    Uri url = buildAPI(
        path: "/products",
        queryParams: {"limit": limit.toString(), "offset": offset.toString()});
    return url.toString();
  }

  _getSingleProduct(JSONData data) {
    int productId = data["productId"] ?? 0;
    Uri url = buildAPI(path: "/products/$productId");
    return url;
  }

  _addProduct(JSONData data) {
    return buildAPI(path: "/products");
  }

  _updateProduct(JSONData data) {
    FSProduct product = data["product"];
    return buildAPI(path: "/products/${product.id}");
  }

  _deleteProduct(JSONData data) {
    FSProduct product = data["product"];
    return buildAPI(path: "/products/${product.id}");
  }
}

class APICallProducts {
  /// Get Products
  Future<List<FSProduct>> getProducts(int limit, int offset) async {
    JSONData data = {"limit": limit, "offset": offset};
    Uri url = NetworkModule.shared.getProductAPI(APIProducts.getProducts, data);
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    List<FSProduct> result =
        FSProduct.parseFromList(response.getResponse()?.data);
    return result;
  }

  /// Get Single product
  Future<FSProduct> getSingleProduct(int productId) async {
    JSONData data = {"productId": productId};
    Uri url =
        NetworkModule.shared.getProductAPI(APIProducts.getSingleProduct, data);
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    FSProduct result = FSProduct.fromJson(response.getResponse()?.data);
    return result;
  }

  /// Add Product
  Future<FSProduct> addProduct(FSProduct product) async {
    Uri url = NetworkModule.shared
        .getProductAPI(APIProducts.addProduct, {"product": product});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.post,
            data: product.toJson());
    FSProduct result = FSProduct.fromJson(response.getResponse()?.data);
    return result;
  }

  Future<FSProduct> updateProduct(FSProduct product) async {
    Uri url = NetworkModule.shared
        .getProductAPI(APIProducts.addProduct, {"product": product});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.put,
            data: product.toJson());
    FSProduct result = FSProduct.fromJson(response.getResponse()?.data);
    return result;
  }

  Future<FSProduct> deleteProduct(FSProduct product) async {
    Uri url = NetworkModule.shared
        .getProductAPI(APIProducts.addProduct, {"product": product});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.put,
            data: product.toJson());
    FSProduct result = FSProduct.fromJson(response.getResponse()?.data);
    return result;
  }
}
