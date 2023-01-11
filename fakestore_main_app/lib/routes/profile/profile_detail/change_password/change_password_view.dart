import 'package:fakestore_main_app/constants/dotenv_constants.dart';
import 'package:fakestore_main_app/extensions/string_extension.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/change_password/change_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../app_utils.dart';
import '../../../../constants/color_constants.dart';
import '../../../../ui/app_ios_navigation_bar.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({super.key, required this.controller});

  late ChangePasswordControllerInterface controller;

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CupertinoPageScaffold(
        navigationBar: FSIOSNavigationBar.create(
            middleText:
                AppUtils.getLocalizationContext(context).change_password_title,
            backButtonPressed: () {
              context.pop();
            }),
        child: Container(
          color: Colors.white,
          child: _buildListView(),
        ),
      );
    });
  }

  _buildListView() {
    List<Widget> listWidgets = [];
    // current password
    listWidgets.add(_buildTextField(
        textEditController: widget.controller.currentPassword.value,
        title: AppUtils.getLocalizationContext(context)
            .change_password_current_password));
    // new password
    listWidgets.add(_buildTextField(
        textEditController: widget.controller.newPassword.value,
        title: AppUtils.getLocalizationContext(context)
            .change_password_new_password));
    // verify password
    listWidgets.add(_buildTextField(
        textEditController: widget.controller.verifyNewPassword.value,
        title: AppUtils.getLocalizationContext(context)
            .change_password_verify_new_password));
    // password validator
    listWidgets.add(_buildPasswordValidator());
    // build save button
    listWidgets.add(_buildSaveButton());
    return ListView(
      children: listWidgets,
    );
  }

  _buildTextField(
      {required TextEditingController textEditController,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
      child: Container(
        height: 60.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                width: 1.0,
                color: Colors.black12,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  // value
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 0.0),
                    child: CupertinoTextField(
                      controller: textEditController,
                      keyboardType: TextInputType.text,
                      enabled: true,
                      obscureText: true,
                      style: const TextStyle(fontSize: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                    ),
                  )
                ],
              ),
            )
            // trailing button
          ],
        ),
        decoration: BoxDecoration(
            color: ColorConstants.colorF7F7F7,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.black12)),
      ),
    );
  }

  _buildValidationItem({required String text, required isValid}) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            // check mark icon
            SizedBox(
              width: 30.0,
            ),
            Icon(
              isValid ? Icons.check_circle : Icons.close_rounded,
              size: 14,
              color: isValid ? Colors.lightGreen : ColorConstants.colorE30404,
            ),
            SizedBox(
              width: 5,
            ),
            // text
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Container(
        child: CupertinoButton(
          onPressed: widget.controller.isAllRulesQualified.value == true
              ? () {
                  _handleSaveButton();
                }
              : null,
          color: ColorConstants.colorE30404,
          disabledColor: ColorConstants.colorF8F8F8,
          child: Text(
            AppUtils.getLocalizationContext(context).save.toUpperCase(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.controller.isAllRulesQualified.value
                    ? Colors.white
                    : Colors.black12),
          ),
        ),
      ),
    );
  }

  _handleSaveButton() {
    widget.controller.isAllRulesQualified.toggle();
  }

  _buildPasswordValidator() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // password must have
          Padding(
            padding: const EdgeInsets.only(
                left: 30, top: 20.0, right: 30.0, bottom: 20.0),
            child: Text(
              AppUtils.getLocalizationContext(context)
                  .change_password_password_must_have,
              style: TextStyle(
                  fontSize: 12.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          // 1st row
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // character minimum count
                _buildValidationItem(
                    text: _getMinimumCharacterCount(),
                    isValid:
                        widget.controller.passwordRules.value.minimumCharacter),
                // special letter
                _buildValidationItem(
                    text: _getSpecialLetterCount(),
                    isValid: widget
                        .controller.passwordRules.value.specialLetterCount)
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // 2nd row
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // uppercase letter
                _buildValidationItem(
                    text: _getUpprcaseLetter(),
                    isValid:
                        widget.controller.passwordRules.value.uppercaseLetter),
                // number count
                _buildValidationItem(
                    text: _getNumberCount(),
                    isValid: widget.controller.passwordRules.value.numberCount),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          // 3rd row
          Container(
            child: Row(
              children: [
                // lowercase letter
                _buildValidationItem(
                    text: _getLowercaseLetter(),
                    isValid:
                        widget.controller.passwordRules.value.lowercaseLetter),
                // verify password match
                _buildValidationItem(
                    text: _getPasswordMatch(),
                    isValid: widget
                        .controller.passwordRules.value.verifyPasswordMatch)
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMinimumCharacterCount() {
    return AppUtils.getLocalizationContext(context)
        .password_validation_rule_character_count
        .format([
      dotenv.get(DotEnvConstants.PWD_VALIDATION_RULE_MINIMUM_CHARACTER_COUNT)
    ]);
  }

  String _getSpecialLetterCount() {
    String numberOfLetterCount =
        dotenv.get(DotEnvConstants.PWD_VALIDATION_RULE_SPECIAL_LETTER);
    String letterDesc = numberOfLetterCount == "1"
        ? AppUtils.getLocalizationContext(context).letter
        : AppUtils.getLocalizationContext(context).letters;
    return AppUtils.getLocalizationContext(context)
        .password_validation_rule_special_letter_count
        .format([numberOfLetterCount, letterDesc]);
  }

  String _getUpprcaseLetter() {
    return AppUtils.getLocalizationContext(context)
        .password_validation_rule_upper_letter_character_count
        .format(
            [dotenv.get(DotEnvConstants.PWD_VALIDATION_RULE_UPPERCASE_LETTER)]);
  }

  String _getLowercaseLetter() {
    return AppUtils.getLocalizationContext(context)
        .password_validation_rule_lower_letter_character_count
        .format(
            [dotenv.get(DotEnvConstants.PWD_VALIDATION_RULE_LOWERCASE_LETTER)]);
  }

  String _getNumberCount() {
    return AppUtils.getLocalizationContext(context)
        .password_validation_rule_lower_number_count
        .format([dotenv.get(DotEnvConstants.PWD_VALIDATION_RULE_NUMBER_COUNT)]);
  }

  String _getPasswordMatch() {
    return AppUtils.getLocalizationContext(context)
        .password_validation_rule_verify_password_match;
  }
}
