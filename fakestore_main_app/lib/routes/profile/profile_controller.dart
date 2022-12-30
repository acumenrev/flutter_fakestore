import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

abstract class ProfileControllerInterface extends BaseController {
  late Rx<FSUser?> _currentUser;
  setCurrentUser(FSUser? user);
  FSUser? getCurrentUser();
  late Rx<bool> emailNotifications;
  late Rx<bool> pushNotifications;
  late Rx<int> numberOfOrderToPay;
  late Rx<int> numberOfOrderToShip;
  late Rx<int> numberOfOrderToReceive;
  late Rx<int> numberOfOrderToCompleted;
  late Rx<int> numberOfOrderToCancelled;
  late Rx<int> numberOfOrderToReturnRefund;
}

class ProfileControllerImplementation extends ProfileControllerInterface {
  ProfileControllerImplementation({required Rx<FSUser?> user}) {
    _currentUser = user;
    _init();
  }

  _init() {
    emailNotifications = false.obs;
    pushNotifications = false.obs;
    numberOfOrderToPay = 0.obs;
    numberOfOrderToShip = 0.obs;
    numberOfOrderToReceive = 0.obs;
    numberOfOrderToCompleted = 0.obs;
    numberOfOrderToCancelled = 0.obs;
    numberOfOrderToReturnRefund = 0.obs;
  }

  @override
  FSUser? getCurrentUser() {
    return _currentUser.value;
  }

  @override
  setCurrentUser(FSUser? user) {
    _currentUser.value = user;
  }
}
