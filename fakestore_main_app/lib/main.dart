import 'package:fakestore_main_app/constants/font_constants.dart';
import 'package:fakestore_main_app/managers/theme_manager.dart';
import 'package:fakestore_main_app/routes/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.shared.getRouter(),
      theme: ThemeManager.shared.getCurrentTheme(),
    );
  }
}
