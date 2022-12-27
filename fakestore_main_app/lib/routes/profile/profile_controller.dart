import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

abstract class ProfileControllerInterface extends BaseController {
  late Rx<FSUser?> _currentUser;
  setCurrentUser(FSUser? user);
  FSUser? getCurrentUser();
  late Rx<bool> emailNotifications;
  late Rx<bool> pushNotifications;
}

class ProfileControllerImplementation extends ProfileControllerInterface {
  ProfileControllerImplementation({FSUser? user}) {
    _currentUser.value = user;
  }

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
