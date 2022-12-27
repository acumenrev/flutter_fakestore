import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/constants/image_constants.dart';
import 'package:fakestore_main_app/routes/profile/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key, required this.controller});

  late ProfileControllerInterface controller;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      child: Column(
        children: _buildMainScreen(),
      ),
    );
  }

  _buildMainScreen() {
    List<Widget> listWidget = [];
    listWidget.add(_buildTopInformation());
    listWidget.addAll(_buildProfileSubItems());
    return listWidget;
  }

  _buildTopInformation() {
    return Container(
      color: Colors.black12,
      height: 150,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Row(
            children: [
              // avatar
              _buildImageCover(),
              // info: name, email
              _buildUserInfo()
            ],
          )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _buildImageCover() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
        child: Container(
          child: CachedNetworkImage(
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Image.asset(ImageConstants.avatarPlaceholder),
            imageUrl:
                "https://images.unsplash.com/photo-1561045439-ce8ec5bc42f8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
          ),
        ),
      ),
    );
  }

  _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // name
            Text(
              "Test User adas ds2ssss",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // email
            Text(
              "sssg@email.com",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.lightBlueAccent,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  _buildSubHeadline({required String subHeadlineText}) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              subHeadlineText,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  _buildMenuItem(
      {required String name,
      required IconData menuIcon,
      String desc = "",
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        child: Row(
          children: [
            // icon
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 20.0, right: 10.0),
              child: Icon(
                menuIcon,
                color: Colors.blue,
              ),
            ),
            // name & desc
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // name
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // desc
                  Text(
                    desc,
                    style: TextStyle(
                        fontSize: 12, color: Colors.black.withOpacity(0.5)),
                  )
                ],
              ),
            ),
            // Arrow icon
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildProfileSubItems() {
    List<Widget> listWidget = [];
    listWidget.add(_buildSubHeadline(subHeadlineText: "PROFILE"));
    listWidget.add(_buildMenuItem(
        onTap: () {},
        name: "Profile Details",
        menuIcon: Icons.person_outline_outlined,
        desc: "Xin chào"));

    listWidget.add(Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Container(
        height: 1.0,
        color: Colors.black.withOpacity(0.3),
      ),
    ));
    return listWidget;
  }

  _buildOrderSubItems() {}

  _buildSettingsSubItems() {}
}
