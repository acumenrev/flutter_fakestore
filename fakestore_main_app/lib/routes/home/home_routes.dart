import 'package:fakestore_main_app/routes/home/product_detail/product_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';
import 'home_controller.dart';
import 'home_view.dart';
import 'product_detail/product_detail_controller.dart';

enum HomeRoutesLocation { home, productDetail }

class HomeRoutes implements BaseRoutes {
  @override
  late GoRoute routes;

  String getPageLocation(HomeRoutesLocation location) {
    String result = "";
    switch (location) {
      case HomeRoutesLocation.home:
        // TODO: Handle this case.
        break;
      case HomeRoutesLocation.productDetail:
        // TODO: Handle this case.
        break;
    }
    return result;
  }

  HomeRoutes() {
    routes = GoRoute(
        path: getPageLocation(HomeRoutesLocation.home),
        builder: (ctx, state) {
          return HomeView(controller: Get.put(HomeControllerImplementation()));
        },
        routes: [_getProductDetail()]);
  }

  GoRoute _getProductDetail() {
    return GoRoute(
        path: "detail",
        builder: (ctx, state) {
          return ProductDetailView(
              controller: ProductDetailControllerImplementation());
        });
  }
}
