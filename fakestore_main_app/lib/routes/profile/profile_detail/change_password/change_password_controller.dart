import 'dart:async';

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
  late TextEditingController tecCurrentPassword;
  late TextEditingController tecNewPassword;
  late TextEditingController tecVerifyNewPassword;
  late StreamController<String> scCurrentPwd;
  late StreamController<String> scNewPwd;
  late StreamController<String> scVerifyPwd;
  late Rx<PasswordRules> passwordRules;
  late RxBool isAllRulesQualified;

  updateNewPasswordAndVerify(
      {required String newPwd, required String verifyPwd}) {}

  destroy() {}
}

class ChangePasswordControllerImplementation
    extends ChangePasswordControllerInterface {
  ChangePasswordControllerImplementation() {
    tecCurrentPassword = TextEditingController(text: "");
    tecNewPassword = TextEditingController(text: "");
    tecVerifyNewPassword = TextEditingController(text: "");
    passwordRules = PasswordRules().obs;
    isAllRulesQualified = RxBool(false);
    _setupObservers();
    _setupStreams();
  }

  @override
  destroy() {
    scVerifyPwd.close();
    scCurrentPwd.close();
    scNewPwd.close();
    tecCurrentPassword.dispose();
    tecNewPassword.dispose();
    tecVerifyNewPassword.dispose();
  }

  _setupObservers() {
    passwordRules.listen((value) {
      isAllRulesQualified.value = value.isValid();
    });
  }

  _setupStreams() {
    scCurrentPwd = StreamController<String>.broadcast();
    scNewPwd = StreamController<String>.broadcast();
    scVerifyPwd = StreamController<String>.broadcast();
    tecCurrentPassword.addListener(() {
      scCurrentPwd.sink.add(tecCurrentPassword.text.trim());
    });
    tecNewPassword.addListener(() {
      scNewPwd.sink.add(tecCurrentPassword.text.trim());
    });
    tecVerifyNewPassword.addListener(() {
      scVerifyPwd.sink.add(tecCurrentPassword.text.trim());
    });
  }
}
