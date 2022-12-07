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
    List<JSONData> listJsonProducts = data["products"];
  }

  static List<FSCart> parseFromList(List<JSONData> listJson) {
    List<FSCart> list = [];
    FSCart? temp;
    for (var element in listJson) {
      temp = null;
      temp = FSCart.fromJson(element);
      list.add(temp!);
    }
    return list;
  }
}
