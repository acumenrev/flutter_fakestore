import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:fakestore_main_app/routes/home/home_view.dart';
import 'package:fakestore_main_app/routes/main/main_controller.dart';
import 'package:fakestore_main_app/routes/main/main_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_view.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static AppRouter shared = AppRouter();
  late GoRouter _router;

  GoRouter getRouter() {
    return _router;
  }

  AppRouter() {
    setupRouter();
  }

  setupRouter() {
    _router = GoRouter(routes: [_getHomeRoute()]);
  }

  _getHomeRoute() {
    return GoRoute(
        path: "/",
        builder: (context, state) {
          return MainView(controller: Get.put(MainControllerImplementation()));
        });
  }

  _getProfileDetail() {
    return GoRoute(
        path: "/profile",
        builder: (ctx, state) {
          return ProfileDetailView(
              controller: Get.put(ProfileDetailImplementation()));
        });
  }
}
