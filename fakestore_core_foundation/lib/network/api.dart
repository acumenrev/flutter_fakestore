import 'package:dio/dio.dart';
import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:fakestore_core_foundation/network/api_category.dart';
import 'package:fakestore_core_foundation/network/api_products.dart';
import 'package:tf_framework/models/base_error.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';
import 'package:tuple/tuple.dart';

import 'api_user.dart';

class NetworkModule {
  String _baseUrl = "";
  late final TFHTTPClient _httpClient;
  late final APICallCategories apiCallCategories;
  late final APICallProducts apiProducts;
  late final APICallUsers apiUsers;
  late final APICallCarts apiCarts;
  static NetworkModule shared = NetworkModule();

  NetworkModule({Dio? dio, String baseUrl = "fakestoreapi.com"}) {
    _baseUrl = baseUrl;
    _httpClient = TFHTTPClient(dio: dio);
    apiCallCategories = APICallCategories();
    apiProducts = APICallProducts();
    apiUsers = APICallUsers();
    apiCarts = APICallCarts();
  }

  setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  setHTTPClient(TFHTTPClient client) {
    _httpClient = client;
  }

  getBaseUrl() {
    return _baseUrl;
  }

  TFHTTPClient getHTTPClient() {
    return _httpClient;
  }

  Uri buildAPI({required String path, QueryParams? queryParams}) {
    var uri = Uri(
        scheme: "https",
        host: _baseUrl,
        path: path,
        queryParameters: queryParams != null
            ? (queryParams.isEmpty == false ? queryParams : null)
            : null);

    return uri;
  }

  /// Convert Map<String, dynamic> to Map<String, String>
  Map<String, String> convertMapStringDynamicToMapStringString(JSONData data) {
    QueryParams queryParams =
        data.map((key, value) => MapEntry(key, value.toString()));
    return queryParams;
  }
}
