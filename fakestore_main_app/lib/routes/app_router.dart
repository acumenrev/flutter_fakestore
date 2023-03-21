import 'package:fakestore_main_app/routes/home/home_routes.dart';
import 'package:fakestore_main_app/routes/main/main_controller.dart';
import 'package:fakestore_main_app/routes/main/main_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_routes.dart';
import 'package:fakestore_main_app/ui/scafford_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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

  _setupRouterWithShellRoutes() {
    _router = GoRouter(
        initialLocation: "/",
        debugLogDiagnostics: true,
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                  child: ScaffoldWithNavBar(
                location: state.location,
                child: child,
              ));
            },
            routes: [
              GoRoute(
                path: '/',
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: Scaffold(
                      body: Center(child: Text("Home")),
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/discover',
                parentNavigatorKey: _shellNavigatorKey,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: Scaffold(
                      body: Center(child: Text("Discover")),
                    ),
                  );
                },
              ),
              GoRoute(
                  parentNavigatorKey: _shellNavigatorKey,
                  path: AppRouter.shared
                      .getProfileRoutes()
                      .getPageLocation(ProfileRoutesLocation.profile),
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(
                      child: Scaffold(
                        body: Center(child: Text("Shop")),
                      ),
                    );
                  }),
            ],
          ),
          GoRoute(
              path: "/login",
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: Scaffold(
                  appBar: AppBar(),
                  key: UniqueKey(),
                  body: const Center(
                    child: Text("Login"),
                  ),
                ));
              })
        ]);
  }
}

extension MainRoutes on AppRouter {
  _setupMainRoutes() {
    return GoRoute(
        path: "/",
        builder: (context, state) {
          return MainView(controller: Get.put(MainControllerImplementation()));
        },
        routes: [_profileRoutes.routes, _homeRoutes.routes]);
  }
}
