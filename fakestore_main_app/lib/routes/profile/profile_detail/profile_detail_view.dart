import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/constants/image_constants.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailView extends StatefulWidget {
  ProfileDetailView({super.key, required this.controller});

  late ProfileDetailInterface controller;

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: _buildMainUI(),
      ),
    );
  }

  _buildMainUI() {
    List<Widget> listWidget = [];
    listWidget.add(_buildImageCover());
    listWidget.add(_buildBackButton());
    return listWidget;
  }

  _buildBackButton() {
    return Container(
      child: OutlinedButton(
        child: Text("BACK"),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }

  // avatar
  _buildImageCover() {
    return Container(
      height: 100,
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
          child: Container(
            width: 100,
            height: 100,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Image.asset(ImageConstants.avatarPlaceholder),
              imageUrl:
                  "https://images.unsplash.com/photo-1561045439-ce8ec5bc42f8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
            ),
          ),
        ),
      ),
    );
  }
  // email

  // password

}
