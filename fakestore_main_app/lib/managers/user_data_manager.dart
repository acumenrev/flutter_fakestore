import 'package:get/get.dart';

class UserDataManager {
  static final UserDataManager shared = UserDataManager._();

  // private constructor
  UserDataManager._() {}

  Rx<int> numberOfItemsInCart = 12.obs;
}
