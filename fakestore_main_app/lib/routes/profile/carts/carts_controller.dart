import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:fakestore_core_foundation/models/fs_cart.dart';

enum UserCartsTabs { all, discount, buyAgain }

abstract class CartsControllerInterface extends BaseController {
  late RxList<FSCart> carts;
  late Rx<UserCartsTabs> currentSelectedTab;
  late RxInt unreadMessages;
  late RxBool isEdit;
}

class CartsControllerImplementation extends CartsControllerInterface {
  CartsControllerImplementation() {
    carts = RxList<FSCart>([]);
    unreadMessages = 12.obs;
    currentSelectedTab = UserCartsTabs.all.obs;
    isEdit = RxBool(false);
  }
}
