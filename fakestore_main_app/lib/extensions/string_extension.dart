import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/dotenv_constants.dart';

String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 1; i < params.length + 1; i++) {
    result = result.replaceAll('%${i}', params[i - 1]);
  }

  return result;
}

extension StringExtension on String {
  String format(List<String> params) => interpolate(this, params);

  bool isValidEmail() {
    String regExString =
        "[A-Z0-9a-z.!#\$%&'*+/=?^_`{|}~-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    return regexCheck(regExString);
  }

  bool haveAtLeastUppercaseLetters({required int numberOfUppercaseLetters}) {
    String regExString = dotenv
        .get(DotEnvConstants.REGEX_PWD_UPPERCASE_LETTER)
        .format([numberOfUppercaseLetters.toString()]);
    return regexCheck(regExString);
  }

  bool haveAtLeastLowercaseLetters({required int numberOfLowercaseLetters}) {
    String regExString = dotenv
        .get(DotEnvConstants.REGEX_PWD_LOWERCASE_LETTER)
        .format([numberOfLowercaseLetters.toString()]);
    return regexCheck(regExString);
  }

  bool haveAtLeastDigit({required int numberOfDigits}) {
    String regExString = dotenv
        .get(DotEnvConstants.REGEX_PWD_DIGIT_LETTER)
        .format([numberOfDigits.toString()]);
    return regexCheck(regExString);
  }

  bool haveAtLeastSpecialLetter({required int numberOfSpecialLetters}) {
    String regExString = dotenv
        .get(DotEnvConstants.REGEX_PWD_SPECIAL_LETTER)
        .format([numberOfSpecialLetters.toString()]);
    return regexCheck(regExString);
  }

  bool haveAtLeastLength({required int minimumLength}) {
    String regExString = dotenv
        .get(DotEnvConstants.REGEX_PWD_LENGTH)
        .format([minimumLength.toString()]);
    return regexCheck(regExString);
  }

  bool regexCheck(String regularExString) {
    RegExp regularEx = RegExp(regularExString);
    return regularEx.hasMatch(this);
  }
}
