import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:fakestore_core_foundation/network/api_category.dart';
import 'package:fakestore_core_foundation/network/api_products.dart';
import 'package:tf_framework/models/base_model.dart';

import 'api_user.dart';

class API {
  String _baseUrl = "";
  static API shared = API();
  APICallCategories apiCallCategories = APICallCategories();
  APICallProducts apiProducts = APICallProducts();
  APICallUsers apiUsers = APICallUsers();
  API() {
    _baseUrl = "fakestoreapi.com";
  }

  setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  getBaseUrl() {
    return _baseUrl;
  }

  Uri buildAPI({required String path, QueryParams? queryParams}) {
    var uri = Uri(
        scheme: "https",
        host: _baseUrl,
        path: path,
        queryParameters: queryParams != null
            ? (queryParams?.isEmpty == false ? queryParams : null)
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
