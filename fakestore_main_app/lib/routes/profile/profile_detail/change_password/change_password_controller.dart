import 'package:async/async.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
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

  void validateInputs(
      {required String currentPwd,
      required String newPwd,
      required String verifyPwd}) {}

  bool isValid() {
    return (minimumCharacter &&
        specialLetterCount &&
        uppercaseLetter &&
        lowercaseLetter &&
        numberCount &&
        verifyPasswordMatch);
  }
}

abstract class ChangePasswordControllerInterface extends BaseController {
  late Rx<TextEditingController> currentPassword;
  late Rx<TextEditingController> newPassword;
  late Rx<TextEditingController> verifyNewPassword;
  late Rx<PasswordRules> passwordRules;
  late RxBool isAllRulesQualified;

  updateNewPasswordAndVerify(
      {required String newPwd, required String verifyPwd}) {}
}

class ChangePasswordControllerImplementation
    extends ChangePasswordControllerInterface {
  ChangePasswordControllerImplementation() {
    currentPassword = TextEditingController(text: "").obs;
    newPassword = TextEditingController(text: "").obs;
    verifyNewPassword = TextEditingController(text: "").obs;
    passwordRules = PasswordRules().obs;
    isAllRulesQualified = RxBool(false);
    _setupObservers();
  }

  _setupObservers() {
    passwordRules.listen((value) {
      isAllRulesQualified.value = value.isValid();
    });

    final sgUserInput = StreamGroup.merge(
        [currentPassword.stream, verifyNewPassword.stream, newPassword.stream]);
  }
}
