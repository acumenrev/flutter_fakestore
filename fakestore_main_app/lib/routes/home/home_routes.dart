import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_main_app/routes/home/product_detail/product_detail_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        result = "home";
        break;
      case HomeRoutesLocation.productDetail:
        result = "/home/detail";
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
        pageBuilder: (context, state) {
          FSProduct product = state.extra as FSProduct;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ProductDetailView(
              controller:
                  ProductDetailControllerImplementation(product: product),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        });
  }

  /// Open Product Detail with Product object
  openProductDetail(BuildContext ctx, FSProduct product) {
    ctx.push(getPageLocation(HomeRoutesLocation.productDetail), extra: product);
  }
}
