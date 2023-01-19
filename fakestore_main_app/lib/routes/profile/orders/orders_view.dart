import 'package:fakestore_main_app/routes/profile/orders/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../app_utils.dart';
import '../../../ui/app_ios_navigation_bar.dart';

class ProfileOrders extends StatelessWidget {
  ProfileOrders(
      {Key? key, required ProfileOrdersControllerInterface controller}) {
    this.controller = controller;
  }
  late BuildContext ctx;
  late ProfileOrdersControllerInterface controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: FSIOSNavigationBar.create(
          middleText: AppUtils.getLocalizationContext(context).orders,
          backButtonPressed: () {
            context.pop();
          }),
      child: Stack(
        children: [],
      ),
    );
  }

  List<Widget> _buildMainStackViewChildren() {
    List<Widget> list = [];
    list.add(Container(
      color: Colors.white,
      child: Container(),
    ));
    if (controller.isLoading.isTrue) {
      list.add(Container(
        child: Stack(
          children: [
            // black background
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            // circular progress indicator
            Center(
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ),
      ));
    }

    return list;
  }
}
