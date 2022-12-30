import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:fakestore_main_app/routes/home/home_view.dart';
import 'package:fakestore_main_app/routes/main/main_controller.dart';
import 'package:fakestore_main_app/routes/main/main_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

abstract class BaseRoutes {
  late GoRoute routes;
}

class AppRouter {
  static AppRouter shared = AppRouter._();
  late GoRouter _router;
  late ProfileRoutes _profileRoutes;

  GoRouter getRouter() {
    return _router;
  }

  ProfileRoutes getProfileRoutes() {
    return _profileRoutes;
  }

  AppRouter._() {
    setupRouter();
  }

  setupRouter() {
    _profileRoutes = ProfileRoutes();
    _router = GoRouter(routes: [_setupMainRoutes()]);
  }
}

extension MainRoutes on AppRouter {
  _setupMainRoutes() {
    return GoRoute(
        path: "/",
        builder: (context, state) {
          return MainView(controller: Get.put(MainControllerImplementation()));
        },
        routes: [_profileRoutes.routes]);
  }
}
