import 'package:fakestore_core_foundation/models/fs_order.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

abstract class ProfileOrdersControllerInterface extends BaseController {
  late Rx<OrderStatus> currentSelectedTab;
  late RxInt unreadMessages;
  late RxList<FSOrder> orders;
}

class ProfileOrdersControllerImplementation
    extends ProfileOrdersControllerInterface {
  ProfileOrdersControllerImplementation(
      {OrderStatus selectedTab = OrderStatus.toPay}) {
    currentSelectedTab = selectedTab.obs;
    unreadMessages = RxInt(14);
    orders = RxList<FSOrder>.empty(growable: true);
  }
}
