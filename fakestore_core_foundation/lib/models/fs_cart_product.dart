import 'package:tf_framework/models/base_model.dart';

class FSCartProduct extends TFModel {
  late int productId;
  late int quantity;

  FSCartProduct.fromJson(JSONData? data) {
    productId = data?["productId"] ?? 0;
    quantity = data?["quantity"] ?? 0;
  }

  static List<FSCartProduct> parseFromList(List<dynamic>? listJson) {
    if (listJson == null) {
      return [];
    }
    List<FSCartProduct> list = [];
    FSCartProduct? temp;
    for (var element in listJson) {
      temp = null;
      temp = FSCartProduct.fromJson(element);
      list.add(temp);
    }
    return list;
  }

  @override
  JSONData? toJson() {
    return {"productId": productId, "quantity": quantity};
  }
}
