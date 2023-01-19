import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

enum ProfileOrdersTab {
  toPay,
  toShip,
  toReceive,
  completed,
  cancelled,
  returnOrRefund
}

abstract class ProfileOrdersControllerInterface extends BaseController {
  late Rx<ProfileOrdersTab> currentSelectedTab;
  late RxInt unreadMessages;
}

class ProfileOrdersControllerImplementation
    extends ProfileOrdersControllerInterface {
  ProfileOrdersControllerImplementation(
      {ProfileOrdersTab selectedTab = ProfileOrdersTab.toPay}) {
    currentSelectedTab = selectedTab.obs;
    unreadMessages = RxInt(12);
  }
}
