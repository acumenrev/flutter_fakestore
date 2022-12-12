import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

import '../models/fs_category.dart';
import 'api_call.dart';
import 'api.dart';

enum APIProductCategories { getAllCategories, getProductsInCategory }

// API on Categories
extension APIExtensionCategories on NetworkModule {
  Uri getCategoryAPI(APIProductCategories api, JSONData data) {
    switch (api) {
      case APIProductCategories.getAllCategories:
        return _getAllCategories();
      case APIProductCategories.getProductsInCategory:
        FSProductCategory category = data["category"];
        return _getProductsInCategory(category);
    }
  }

  _getAllCategories() {
    return buildAPI(path: "/products/categories");
  }

  _getProductsInCategory(FSProductCategory category) {
    return buildAPI(path: "/products/category/${category.name}");
  }
}

class APICallCategories extends APICall {
  /// Get all categories
  Future<List<FSProductCategory>> getCategories() async {
    List<FSProductCategory> list = [];
    Uri url = NetworkModule.shared
        .getCategoryAPI(APIProductCategories.getAllCategories, {});
    TFNetworkResponseModel? response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    List<String> names = response?.getResponse()?.data;
    FSProductCategory? temp;
    for (var element in names) {
      temp = null;
      temp = categoryEnumFromString(element);
      list.add(temp!);
    }
    return list;
  }

  /// get products in a category
  Future<List<FSProduct>> getProductsInACategory(
      FSProductCategory category) async {
    List<FSProduct> list = [];
    Uri url = NetworkModule.shared.getCategoryAPI(
        APIProductCategories.getProductsInCategory, {"category": category});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    list.addAll(FSProduct.parseFromList(response.getResponse()?.data));
    return list;
  }
}
