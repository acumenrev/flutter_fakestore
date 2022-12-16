import 'package:flutter/cupertino.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/utils/tf_logger.dart';

import 'fs_cart_product.dart';

class FSCart extends TFModel {
  late int id;
  late int userId;
  late String date;
  late List<FSCartProduct> products;

  FSCart.fromJson(JSONData? data) {
    id = data?["id"] ?? 0;
    userId = data?["userId"] ?? 0;
    date = data?["date"] ?? "";
    products = [];
    if (data?["products"] != null) {
      List<dynamic> listJsonProducts = List<dynamic>.from(data?["products"]);
      products.addAll(FSCartProduct.parseFromList(listJsonProducts));
    }
  }

  static List<FSCart> parseFromList(List<dynamic>? listJson) {
    if (listJson == null) {
      return [];
    }
    List<FSCart> list = [];
    FSCart? temp;
    for (var element in listJson) {
      temp = null;
      temp = FSCart.fromJson(element);
      list.add(temp!);
    }
    return list;
  }

  @override
  JSONData? toJson() {
    List<JSONData> listProducts = [];
    for (var element in products) {
      if (element.toJson() != null) {
        listProducts.add(element.toJson()!);
      }
    }
    JSONData result = {
      "id": id,
      "userId": userId,
      "date": date,
      "products": listProducts
    };
    return result;
  }
}
