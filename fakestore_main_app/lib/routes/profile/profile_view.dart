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
        children: [_buildTopInformation()],
      ),
    );
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
          child: Image.network(
              "https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg"),
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

  _buildSubHeadline() {}

  _buildMenuItem() {}
}
