import 'package:fakestore_main_app/routes/profile/orders/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileOrders extends StatelessWidget {
  ProfileOrders(
      {Key? key, required ProfileOrdersControllerInterface controller}) {
    this.controller = controller;
  }
  late BuildContext ctx;
  late ProfileOrdersControllerInterface controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          child: Text(controller.currentSelectedTab.value.name),
          onPressed: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
