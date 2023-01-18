import 'package:fakestore_main_app/routes/app_router.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/change_password/change_password_controller.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/change_password/change_password_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../managers/user_data_manager.dart';
import 'profile_controller.dart';
import 'profile_view.dart';

enum ProfileRoutesLocation { profile, profileDetail, changePassword }

class ProfileRoutes implements BaseRoutes {
  @override
  late GoRoute routes;

  String getPageLocation(ProfileRoutesLocation location) {
    String result = "";
    switch (location) {
      case ProfileRoutesLocation.profile:
        result = "profile";
        break;
      case ProfileRoutesLocation.profileDetail:
        result = "/profile/detail";
        break;
      case ProfileRoutesLocation.changePassword:
        result = "/profile/detail/change-password";
        break;
    }
    return result;
  }

  ProfileRoutes() {
    routes = GoRoute(
        path: getPageLocation(ProfileRoutesLocation.profile),
        builder: (ctx, state) {
          return ProfileView(
            controller: Get.put(ProfileControllerImplementation(
                user: UserDataManager.shared.currentUser)),
          );
        },
        routes: [_getProfileDetail(), _getChangePassword()]);
  }

  _getProfileDetail() {
    return GoRoute(
        path: "detail",
        builder: (ctx, state) {
          return ProfileDetailView(
              controller: Get.put(ProfileDetailImplementation(
                  user: UserDataManager.shared.currentUser.value)));
        });
  }

  _getChangePassword() {
    return GoRoute(
        path: "detail/change-password",
        builder: (ctx, state) {
          return ChangePasswordView(
              controller: ChangePasswordControllerImplementation());
        });
  }

  openProfileDetail(BuildContext ctx) {
    ctx.push(getPageLocation(ProfileRoutesLocation.profileDetail));
  }

  openChangePassword(BuildContext ctx) {
    ctx.push(getPageLocation(ProfileRoutesLocation.changePassword));
  }
}
