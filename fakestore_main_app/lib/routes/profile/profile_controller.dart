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
  ProfileControllerImplementation({FSUser? user}) {
    _currentUser.value = user;
  }

  @override
  Rx<int> numberOfOrderToCancelled = 0.obs;

  @override
  Rx<int> numberOfOrderToPay = 0.obs;

  @override
  Rx<int> numberOfOrderToShip = 0.obs;

  @override
  Rx<int> numberOfOrderToReceive = 0.obs;

  @override
  Rx<int> numberOfOrderToReturnRefund = 0.obs;

  @override
  Rx<int> numberOfOrderToCompleted = 0.obs;

  @override
  Rx<bool> emailNotifications = false.obs;

  @override
  Rx<bool> pushNotifications = false.obs;

  @override
  Rx<FSUser?> _currentUser = (null as FSUser?).obs;

  @override
  FSUser? getCurrentUser() {
    return _currentUser.value;
  }

  @override
  setCurrentUser(FSUser? user) {
    _currentUser.value = user;
  }
}
