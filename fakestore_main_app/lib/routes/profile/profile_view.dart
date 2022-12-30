import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_core_ui/fakestore_core_ui.dart';
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
  final _orderScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: ListView(
          children: _buildMainScreen(),
        ),
      );
    });
  }

  _buildMainScreen() {
    List<Widget> listWidget = [];
    listWidget.add(_buildTopInformation());
    listWidget.addAll(_buildProfileSubItems());
    listWidget.add(_buildSeparator());
    listWidget.addAll(_buildOrderSubItems());
    listWidget.add(_buildSeparator());
    listWidget.addAll(_buildSettingsSubItems());
    listWidget.add(_buildSeparator());
    listWidget.add(_buildLogOut());
    listWidget.add(const SizedBox(
      height: 40,
    ));
    return listWidget;
  }

  _buildTopInformation() {
    return Container(
      color: ColorConstants.colorE30404,
      height: 150,
      child: Column(
        children: [
          const SizedBox(
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
          const SizedBox(
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
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
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
              widget.controller.getCurrentUser()?.getFullname() ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // email
            Text(
              widget.controller.getCurrentUser()?.email ?? "",
              style: const TextStyle(
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
              color: ColorConstants.colorE30404,
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
                  activeTrackColor: ColorConstants.colorE30404,
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
                color: ColorConstants.colorE30404,
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                color: ColorConstants.colorE30404,
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
    return listWidget;
  }

  _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Container(
        height: 1.0,
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }

  _buildOrderSubItems() {
    List<Widget> listWidget = [];
    listWidget.add(_buildSubHeadline(
        subHeadlineText: AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order));
    listWidget.add(_buildOrderHorizontalItems());
    return listWidget;
  }

  _buildOrderHorizontalItems() {
    return Container(
      height: 80,
      child: ScrollingButtonBar(
        childWidth: 30,
        childHeight: 80,
        foregroundColor: Colors.transparent,
        scrollController: _orderScrollController,
        selectedItemIndex: 0,
        children: [
          // To Pay
          _buildHorizontalItem(
              name: AppUtils.getLocalizationContext(context)
                  .profile_profile_menu_order_to_pay,
              icon: Icons.money_outlined,
              onTap: () {},
              numberOfOrders: 1),
          // To Ship
          _buildHorizontalItem(
              name: AppUtils.getLocalizationContext(context)
                  .profile_profile_menu_order_to_ship,
              icon: Icons.delivery_dining_outlined,
              onTap: () {},
              numberOfOrders: 1),
          // To Receive
          _buildHorizontalItem(
              name: AppUtils.getLocalizationContext(context)
                  .profile_profile_menu_order_to_receive,
              icon: Icons.home_outlined,
              onTap: () {},
              numberOfOrders: 1),
          // Completed
          _buildHorizontalItem(
              name: AppUtils.getLocalizationContext(context)
                  .profile_profile_menu_order_complete,
              icon: Icons.check_circle_outline,
              onTap: () {},
              numberOfOrders: 1),
          // Cancelled
          _buildHorizontalItem(
              name: AppUtils.getLocalizationContext(context)
                  .profile_profile_menu_order_cancelled,
              icon: Icons.cancel_outlined,
              onTap: () {},
              numberOfOrders: 1),
          // Refund Return
          _buildHorizontalItem(
              name: AppUtils.getLocalizationContext(context)
                  .profile_profile_menu_order_return_refund,
              icon: Icons.backspace_outlined,
              onTap: () {},
              numberOfOrders: 1),
        ],
      ),
    );
  }

  _buildHorizontalItem(
      {required String name,
      required IconData icon,
      required VoidCallback onTap,
      required numberOfOrders}) {
    return ButtonsItem(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Text
            Container(
              color: Colors.transparent,
              width: 100,
              height: 30,
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Icon and number of orders
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    size: 30,
                    color: ColorConstants.colorE30404,
                  ),
                )
              ],
            )
          ],
        ),
        onTap: onTap);
  }

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
    return Container(
      width: 160,
      height: 40,
      child: Center(
        child: OutlinedButton(
            onPressed: () {},
            child: Container(
              width: 160,
              height: 40,
              child: Center(
                  child: Text(AppUtils.getLocalizationContext(context)
                      .log_out
                      .toUpperCase())),
            )),
      ),
    );
  }
}
