import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:fakestore_main_app/constants/dotenv_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class PasswordRules {
  late bool minimumCharacter;
  late bool specialLetterCount;
  late bool uppercaseLetter;
  late bool lowercaseLetter;
  late bool numberCount;
  late bool verifyPasswordMatch;

  PasswordRules() {
    minimumCharacter = false;
    specialLetterCount = false;
    uppercaseLetter = false;
    lowercaseLetter = false;
    numberCount = false;
    verifyPasswordMatch = false;
  }
}

abstract class ChangePasswordControllerInterface extends BaseController {
  late Rx<String> currentPassword;
  late Rx<String> newPassword;
  late Rx<String> verifyNewPassword;
  late Rx<PasswordRules> passwordRules;
  late Rx<bool> isAllRulesQualified;

  updateNewPasswordAndVerify(
      {required String newPwd, required String verifyPwd}) {}
}

class ChangePasswordControllerImplementation
    extends ChangePasswordControllerInterface {
  ChangePasswordControllerImplementation() {
    currentPassword = "".obs;
    newPassword = "".obs;
    verifyNewPassword = "".obs;
    passwordRules = PasswordRules().obs;
    isAllRulesQualified = false.obs;
  }
}
