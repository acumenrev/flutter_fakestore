import 'package:fakestore_main_app/routes/home/home_view.dart';
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
    _router = GoRouter(routes: [
      GoRoute(path: "/", builder: (context, state) => HomeScreen()),
    ]);
  }
}
