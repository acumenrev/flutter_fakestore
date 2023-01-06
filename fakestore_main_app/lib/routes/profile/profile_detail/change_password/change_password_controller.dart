import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:fakestore_main_app/constants/dotenv_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

abstract class ChangePasswordControllerInterface extends BaseController {
  late Rx<String> currentPassword;
  late Rx<String> newPassword;
  late Rx<String> verifyNewPassword;
}

class ChangePasswordControllerImplementation
    extends ChangePasswordControllerInterface {
  ChangePasswordControllerImplementation() {
    currentPassword = "".obs;
    newPassword = "".obs;
    verifyNewPassword = "".obs;
  }
}
