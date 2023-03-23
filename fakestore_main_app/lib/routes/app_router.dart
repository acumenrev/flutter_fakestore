import 'package:fakestore_main_app/managers/user_data_manager.dart';
import 'package:fakestore_main_app/routes/home/home_routes.dart';
import 'package:fakestore_main_app/routes/login/login_controller.dart';
import 'package:fakestore_main_app/routes/main/main_controller.dart';
import 'package:fakestore_main_app/routes/main/main_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_routes.dart';
import 'package:fakestore_main_app/ui/scafford_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'login/login_view.dart';

abstract class BaseRoutes {
  late GoRoute routes;
}

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static AppRouter shared = AppRouter._();
  late GoRouter _router;
  late ProfileRoutes _profileRoutes;
  late HomeRoutes _homeRoutes;

  GoRouter getRouter() {
    return _router;
  }

  ProfileRoutes getProfileRoutes() {
    return _profileRoutes;
  }

  HomeRoutes getHomeRoutes() {
    return _homeRoutes;
  }

  AppRouter._() {
    setupRouter();
  }

  setupRouter() {
    _profileRoutes = ProfileRoutes();
    _homeRoutes = HomeRoutes();
    _router = GoRouter(routes: [_setupMainRoutes()]);
  }
}

extension MainRoutes on AppRouter {
  _setupMainRoutes() {
    return GoRoute(
        path: "/",
        builder: (context, state) {
          // check if user is not logged in, then open the login screen
          debugPrint(
              "User is null ${UserDataManager.shared.currentUser.value == null ? "true" : "false"}");
          if (UserDataManager.shared.currentUser.value == null) {
            return LoginView(controller: LoginControllerImplementation());
          }
          return MainView(controller: Get.put(MainControllerImplementation()));
        },
        routes: [_profileRoutes.routes, _homeRoutes.routes]);
  }
}
