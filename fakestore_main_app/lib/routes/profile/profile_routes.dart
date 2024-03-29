import 'package:fakestore_core_foundation/models/fs_order.dart';
import 'package:fakestore_main_app/routes/app_router.dart';
import 'package:fakestore_main_app/routes/profile/carts/carts_controller.dart';
import 'package:fakestore_main_app/routes/profile/carts/carts_view.dart';
import 'package:fakestore_main_app/routes/profile/orders/orders_controller.dart';
import 'package:fakestore_main_app/routes/profile/orders/orders_view.dart';
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

enum ProfileRoutesLocation {
  profile,
  profileDetail,
  changePassword,
  orders,
  carts
}

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
      case ProfileRoutesLocation.orders:
        result = "/profile/orders";
        break;
      case ProfileRoutesLocation.carts:
        result = "/profile/carts";
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
        routes: [
          _getProfileDetail(),
          _getChangePassword(),
          _getOrders(),
          _getCarts()
        ]);
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

  _getOrders() {
    return GoRoute(
        path: "orders",
        builder: (ctx, state) {
          OrderStatus tab = OrderStatus.toPay;
          if (state.extra != null) {
            Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
            tab = extra["tab"] as OrderStatus;
          }

          return ProfileOrders(
              controller:
                  ProfileOrdersControllerImplementation(selectedTab: tab));
        });
  }

  _getCarts() {
    return GoRoute(
        path: "carts",
        builder: (ctx, state) {
          return CartsView(controller: CartsControllerImplementation());
        });
  }

  openProfileDetail(BuildContext ctx) {
    ctx.push(getPageLocation(ProfileRoutesLocation.profileDetail));
  }

  openChangePassword(BuildContext ctx) {
    ctx.push(getPageLocation(ProfileRoutesLocation.changePassword));
  }

  openOrders(BuildContext ctx, OrderStatus tab) {
    ctx.push(getPageLocation(ProfileRoutesLocation.orders),
        extra: {"tab": tab});
  }

  openCarts(BuildContext ctx) {
    ctx.push(getPageLocation(ProfileRoutesLocation.carts));
  }
}
