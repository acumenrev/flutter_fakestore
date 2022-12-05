import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

class APICallProducts {
  /*
   Uri getProductAPI(APIProducts api, JSONData data) {
    switch (api) {
      case APIProducts.getProducts:
        return _getProducts(data);
      case APIProducts.getSingleProduct:
        return _getSingleProduct(data);
      case APIProducts.addProduct:
      case APIProducts.updateProduct:
      case APIProducts.deleteProduct:
        return _deleteProduct(data);
    }
  }
   */

  /// Get Products
  Future<List<FSProduct>> getProducts(int limit, int offset) async {
    JSONData data = {"limit": limit, "offset": offset};
    Uri url = API.shared.getProductAPI(APIProducts.getProducts, data);
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    List<FSProduct> result =
        FSProduct.parseFromList(response.getResponse().data);
    return result;
  }

  /// Get Single product
  Future<FSProduct> getSingleProduct(int productId) async {
    JSONData data = {"productId": productId};
    Uri url = API.shared.getProductAPI(APIProducts.getSingleProduct, data);
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    FSProduct result = FSProduct.fromJson(response.getResponse().data);
    return result;
  }
}
