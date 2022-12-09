import 'package:flutter/cupertino.dart';
import 'package:tf_framework/models/base_model.dart';

import 'fs_cart_product.dart';

class FSCart extends TFModel {
  late int id;
  late int userId;
  late String date;
  late List<FSCartProduct> products;

  FSCart.fromJson(JSONData data) {
    id = data["id"] ?? 0;
    userId = data["userId"] ?? 0;
    date = data["date"] ?? "";
    List<JSONData> listJsonProducts = List<JSONData>.from(data["products"]);
    FSCartProduct? tempCartProduct;
    products = [];
    for (var element in listJsonProducts) {
      tempCartProduct = null;
      tempCartProduct = FSCartProduct.fromJson(element);
      products.add(tempCartProduct);
    }
  }

  static List<FSCart> parseFromList(List<dynamic> listJson) {
    List<FSCart> list = [];
    FSCart? temp;
    for (var element in listJson) {
      temp = null;
      temp = FSCart.fromJson(element);
      list.add(temp!);
    }
    debugPrint("parseFromList: \n $list");
    return list;
  }
}
