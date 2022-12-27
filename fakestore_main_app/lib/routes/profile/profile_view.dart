import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/app_utils.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/constants/image_constants.dart';
import 'package:fakestore_main_app/routes/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: Column(
          children: _buildMainScreen(),
        ),
      );
    });
  }

  _buildMainScreen() {
    List<Widget> listWidget = [];
    listWidget.add(_buildTopInformation());
    listWidget.addAll(_buildProfileSubItems());
    listWidget.addAll(_buildSettingsSubItems());
    listWidget.add(_buildLogOut());
    return listWidget;
  }

  _buildTopInformation() {
    return Container(
      color: ColorConstants.colorE30404,
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
                  color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // email
            Text(
              "sssg@email.com",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
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
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  _buildToggleMenuItem(
      {required String name,
      required IconData menuIcon,
      required bool isSwitched,
      required ValueChanged<bool> onChanged,
      String desc = ""}) {
    return Container(
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
                desc.isNotEmpty
                    ? Text(
                        desc,
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.5)),
                      )
                    : Container()
              ],
            ),
          ),
          // Arrow icon
          Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    onChanged(value);
                  },
                  activeTrackColor: Colors.blue,
                  activeColor: Colors.white))
        ],
      ),
    );
  }

  _buildNavigationMenuItem(
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
                  desc.isNotEmpty
                      ? Text(
                          desc,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5)),
                        )
                      : Container()
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
    listWidget.add(_buildSubHeadline(
        subHeadlineText: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_profile));
    listWidget.add(_buildNavigationMenuItem(
        onTap: () {},
        name: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_profile_details_title,
        menuIcon: Icons.person_outline_outlined,
        desc: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_profile_details_desc));

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

  _buildSettingsSubItems() {
    List<Widget> listWidget = [];
    listWidget.add(_buildSubHeadline(
        subHeadlineText: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_settings));
    // push notifications
    listWidget.add(_buildToggleMenuItem(
        name: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_settings_push_notifications,
        menuIcon: Icons.add_alert_outlined,
        isSwitched: widget.controller.pushNotifications.value,
        onChanged: (value) {
          widget.controller.pushNotifications.value = value;
        }));
    // email notifications
    listWidget.add(_buildToggleMenuItem(
        name: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_settings_email_notifications,
        menuIcon: Icons.email_outlined,
        isSwitched: widget.controller.emailNotifications.value,
        onChanged: (value) {
          widget.controller.emailNotifications.value = value;
        }));
    // terms of use
    listWidget.add(_buildNavigationMenuItem(
        name: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_settings_terms_of_use,
        menuIcon: Icons.book_outlined,
        onTap: () {}));

    // privacy policy
    listWidget.add(_buildNavigationMenuItem(
        name: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_settings_privacy_policy,
        menuIcon: Icons.lock_outline,
        onTap: () {}));
    return listWidget;
  }

  _buildLogOut() {
    return OutlinedButton(
        onPressed: () {},
        child: Container(
          width: 80,
          height: 40,
          child: Center(
              child: Text(AppUtils.getLocalizationContext(context).log_out)),
        ));
  }
}
