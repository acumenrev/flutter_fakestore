import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/constants/image_constants.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:fakestore_main_app/ui/app_ios_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
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
    return CupertinoPageScaffold(
      navigationBar: FSIOSNavigationBar.create(
          middleText: 'Text',
          backButtonPressed: () {
            context.pop();
          }),
      child: Container(
        color: Colors.white,
        child: ListView(
          children: _buildMainUI(),
        ),
      ),
    );
  }

  _buildMainUI() {
    List<Widget> listWidget = [];
    listWidget.add(_buildImageCover());
    return listWidget;
  }

  // avatar
  _buildImageCover() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Container(
        height: 180,
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 180,
            height: 180,
            color: Colors.transparent,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.asset(ImageConstants.avatarPlaceholder),
                      imageUrl:
                          "https://images.unsplash.com/photo-1561045439-ce8ec5bc42f8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      _editAvatarHandler();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue),
                      child: Center(
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _editAvatarHandler() {
    debugPrint("_editAvatarHandler");
  }

  // email

  // password

}
