import 'package:fakestore_main_app/routes/app_router.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/src/route.dart';

class ProfileRoutes implements BaseRoutes {
  @override
  late GoRoute routes;

  ProfileRoutes() {
    routes = GoRoute(
        path: "profile",
        builder: (ctx, state) {
          return Container();
        },
        routes: [_getProfileDetail()]);
  }

  _getProfileDetail() {
    return GoRoute(
        path: "detail",
        builder: (ctx, state) {
          return ProfileDetailView(
              controller: Get.put(ProfileDetailImplementation()));
        });
  }

  openProfileDetail(BuildContext ctx) {
    ctx.push("/profile/detail");
  }
}