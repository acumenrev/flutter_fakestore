import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:tf_framework/models/base_model.dart';

enum APIProducts {
  getProducts,
  getSingleProduct,
  addProduct,
  updateProduct,
  deleteProduct
}

enum APIProductCategories { getAllCategories, getProductsInCategory }

enum APICarts {
  getAllCarts,
  getUserCart,
  getASingleCart,
  addProductToCart,
  updateProductInCart,
  deleteProductFromCart
}

enum APIUsers { getAllUsers, getASingleUser, addUser, updateUser, deleteUser }

class API {
  String _baseUrl = "";
  static API shared = API();
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

/// API For Products
extension APIProductsExt on API {
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

  _getProducts(JSONData data) {
    int limit = data["limit"] ?? 20;
    int offset = data["offset"] ?? 0;
    Uri url = buildAPI(
        path: "/products", queryParams: {"limit": limit, "offset": offset});
    return url.toString();
  }

  _getSingleProduct(JSONData data) {
    int productId = data["productId"] ?? 0;
    Uri url = buildAPI(path: "/products/${productId}");
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

// API on Categories
extension on API {
  Uri? getCategoryAPI(APIProductCategories api, JSONData data) {
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

// API extension for User
extension on API {
  Uri getUserAPI(APIUsers api, JSONData data) {
    switch (api) {
      case APIUsers.getAllUsers:
        return _getAllUsers(data);
      case APIUsers.getASingleUser:
        return _getASingleUser(data);
      case APIUsers.addUser:
        return _addUser(data);
      case APIUsers.updateUser:
        return _updateUser(data);
      case APIUsers.deleteUser:
        return _deleteUser(data);
    }
  }

  _getAllUsers(JSONData data) {
    int limit = data["limit"] ?? 0;
    int sort = data["sort"];

    return buildAPI(
        path: "/users", queryParams: {"limit": limit, "sort": sort});
  }

  _getASingleUser(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/users/${userId}");
  }

  _addUser(JSONData data) {
    return buildAPI(path: "/users");
  }

  _updateUser(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/users/${userId}");
  }

  _deleteUser(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/users/${userId}");
  }
}
