import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProfileDetailInterface extends BaseController {
  late Rx<TextEditingController> controllerEmail;
  late Rx<TextEditingController> controllerName;
  late Rx<TextEditingController> controllerPassword;
}

class ProfileDetailImplementation extends ProfileDetailInterface {
  ProfileDetailImplementation({required FSUser? user}) {
    controllerEmail = TextEditingController(text: user?.email ?? "").obs;
    controllerName = TextEditingController(text: user?.getFullname() ?? "").obs;
    controllerPassword = TextEditingController(text: user?.password ?? "").obs;
  }
}
