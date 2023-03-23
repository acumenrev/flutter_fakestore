import 'package:fakestore_main_app/app_utils.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:fakestore_main_app/managers/user_data_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tf_framework/models/base_error.dart';

abstract class LoginControllerInterface extends BaseController {
  late Rx<TextEditingController> username;
  late Rx<TextEditingController> password;
  late RxBool hidePassword;
  late Rx<RxStatus> loginStatus;
  void login();
}

class LoginControllerImplementation extends LoginControllerInterface {
  LoginControllerImplementation() {
    username = TextEditingController(text: "").obs;
    password = TextEditingController(text: "").obs;
    hidePassword = RxBool(true);
    this.isLoading.value = false;
    loginStatus = RxStatus.empty().obs;
  }

  @override
  void login() async {
    this.isLoading.value = true;
    Future.delayed(const Duration(seconds: 2)).then((value) {
      this.isLoading.value = false;
      if (username.value.value.text == "admin" &&
          password.value.value.text == "password") {
        // Login success
        UserDataManager.shared.loginWithFakeUser();
        loginStatus.value = RxStatus.success();
      } else {
        // login error
        loginStatus.value = RxStatus.error("Invalid Credentials");
      }
    });
  }
}
