import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailView extends StatelessWidget {
  ProfileDetailView({super.key, required this.controller});

  late ProfileDetailInterface controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: OutlinedButton(
        child: Text("back"),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
