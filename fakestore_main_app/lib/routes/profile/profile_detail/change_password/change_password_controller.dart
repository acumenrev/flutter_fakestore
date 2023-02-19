import 'package:async/async.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:fakestore_main_app/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../constants/dotenv_constants.dart';

class PasswordRules {
  late RxBool minimumCharacter;
  late RxBool specialLetterCount;
  late RxBool uppercaseLetter;
  late RxBool lowercaseLetter;
  late RxBool numberCount;
  late RxBool verifyPasswordMatch;
  late RxBool isAllRulesQualified;

  PasswordRules() {
    minimumCharacter = RxBool(false);
    specialLetterCount = RxBool(false);
    uppercaseLetter = RxBool(false);
    lowercaseLetter = RxBool(false);
    numberCount = RxBool(false);
    verifyPasswordMatch = RxBool(false);
    isAllRulesQualified = RxBool(false);
    _setupObservers();
  }

  _setupObservers() {
    final listStreams = [
      minimumCharacter.stream,
      specialLetterCount.stream,
      uppercaseLetter.stream,
      lowercaseLetter.stream,
      numberCount.stream,
      verifyPasswordMatch.stream
    ];

    final finalStream = CombineLatestStream(listStreams, (values) {
      isAllRulesQualified.value = !values.contains(false);
    }).listen((value) {
      // do nothing here
    });
  }
}

abstract class ChangePasswordControllerInterface extends BaseController {
  late RxString currentPwd;
  late RxString newPwd;
  late RxString verifyPwd;
  late PasswordRules passwordRules;
  late RxBool isAllRulesQualified;
  late Rxn<Function()> submitFunc;

  void currentPwdChanged(String val) {}
  void newPwdChanged(String val) {}
  void verifyPwdChanged(String val) {}

  updateNewPasswordAndVerify(
      {required String newPwd, required String verifyPwd}) {}

  destroy() {}
  Function? saveSuccess;
}

class ChangePasswordControllerImplementation
    extends ChangePasswordControllerInterface {
  ChangePasswordControllerImplementation() {
    passwordRules = PasswordRules();
    isAllRulesQualified = RxBool(false);
    submitFunc = Rxn<Function()>(null);
    currentPwd = RxString("");
    newPwd = RxString("");
    verifyPwd = RxString("");
    _setupObservers();
  }

  @override
  destroy() {}

  _setupObservers() {
    // new password
    newPwd.listen((p0) {
      passwordRules.numberCount.value = newPwd.value.haveAtLeastDigit(
          numberOfDigits: int.parse(
              dotenv.get(DotEnvConstants.PWD_VALIDATION_RULE_NUMBER_COUNT)));
      passwordRules.lowercaseLetter.value = newPwd.value
          .haveAtLeastLowercaseLetters(
              numberOfLowercaseLetters: int.parse(dotenv
                  .get(DotEnvConstants.PWD_VALIDATION_RULE_LOWERCASE_LETTER)));
      passwordRules.uppercaseLetter.value = newPwd.value
          .haveAtLeastUppercaseLetters(
              numberOfUppercaseLetters: int.parse(dotenv
                  .get(DotEnvConstants.PWD_VALIDATION_RULE_UPPERCASE_LETTER)));
      passwordRules.specialLetterCount.value = newPwd.value
          .haveAtLeastSpecialLetter(
              numberOfSpecialLetters: int.parse(dotenv
                  .get(DotEnvConstants.PWD_VALIDATION_RULE_SPECIAL_LETTER)));
      passwordRules.minimumCharacter.value = newPwd.value.haveAtLeastLength(
          minimumLength: int.parse(dotenv.get(
              DotEnvConstants.PWD_VALIDATION_RULE_MINIMUM_CHARACTER_COUNT)));
    });

    // verify new password
    verifyPwd.listen((p0) {
      passwordRules.verifyPasswordMatch.value =
          (verifyPwd.value == newPwd.value);
    });

    final streamForSaveButton = CombineLatestStream(
        [currentPwd.stream, passwordRules.isAllRulesQualified.stream],
        (values) {
      validateForSaveButton();
    }).listen((value) {
      // do nothing here
    });
  }

  @override
  void currentPwdChanged(String val) {
    currentPwd.value = val;
  }

  @override
  void newPwdChanged(String val) {
    newPwd.value = val;
  }

  @override
  void verifyPwdChanged(String val) {
    verifyPwd.value = val;
  }

  void validateForSaveButton() {
    submitFunc.value = null;
    if (currentPwd.value.isNotEmpty &&
        passwordRules.isAllRulesQualified.value) {
      submitFunc.value = submitFunction;
    }
  }

  void submitFunction() {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 3), () {
      debugPrint("called submitFunction");
      isLoading.value = false;
      if (saveSuccess != null) {
        saveSuccess!();
      }
    });
  }
}
