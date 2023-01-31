import 'package:tf_framework/models/base_model.dart';

enum OrderStatus {
  toPay,
  toShip,
  toReceive,
  completed,
  cancelled,
  returnOrRefund
}

class FSOrder extends TFModel {
  late int id;
  late OrderStatus orderStatus;
}
