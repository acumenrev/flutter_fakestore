import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_core_ui/fakestore_core_ui.dart';
import 'package:fakestore_main_app/app_utils.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/constants/font_constants.dart';
import 'package:fakestore_main_app/managers/user_data_manager.dart';
import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:fakestore_main_app/routes/home/home_view.dart';
import 'package:fakestore_main_app/routes/profile/profile_controller.dart';
import 'package:fakestore_main_app/routes/profile/profile_view.dart';
import 'package:fakestore_main_app/routes/wishlist/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainView extends StatefulWidget {
  MainView({super.key, required this.controller});

  late MainControllerInterface controller;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _scrollController = ScrollController();
  final _pageViewController = PageController(initialPage: 0);
  List<Widget> _listScreen = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          left: true,
          top: true,
          right: true,
          bottom: true,
          child: Container(
            child: Column(
              children: [
                _buildHead(UserDataManager.shared.numberOfItemsInCart.value),
                _buildContent()
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }

  _buildContent() {
    return Expanded(
        child: PageView(
      children: _getListScreen(),
      controller: _pageViewController,
    ));
  }

  _getListScreen() {
    if (_listScreen.isEmpty) {
      _listScreen.add(_buildHomeView());
      _listScreen.add(_buildWishlishView());
      _listScreen.add(_buildProfileView());
    }
    return _listScreen;
  }

  _buildHomeView() {
    return HomeView(controller: Get.put(HomeControllerImplementation()));
  }

  _buildWishlishView() {
    return WishlistView();
  }

  _buildProfileView() {
    return ProfileView(
      controller: Get.put(ProfileControllerImplementation(
          user: UserDataManager.shared.currentUser)),
    );
  }

  _buildHead(int numberOfItemsInCart) {
    return Container(
      height: 50,
      child: Row(
        children: [
          // brand name
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Center(
              child: Text(
                "Fakestore",
                style: TextStyle(
                    fontFamily: FontConstants.getFont(
                        fontName: AppFonts.Rubik_Gemstones),
                    fontSize: 30,
                    color: ColorConstants.colorE30404),
              ),
            ),
          ),
          Expanded(child: Container()),
          // cart items
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                child: InkWell(
                  onTap: () {
                    // tap handler
                  },
                  child: Stack(
                    children: [
                      // icon
                      Center(child: Icon(Icons.shopping_cart)),
                      // number
                      Positioned(
                        child: Container(
                          width: 22,
                          height: 22,
                          child: Center(
                              child: Text(
                            numberOfItemsInCart.toString(),
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                        ),
                        right: 0,
                        top: 0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavyBar(
      selectedIndex: widget.controller.getSelectedTabIndex(),
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        widget.controller.setSelectedTabIndex(index);
        _pageViewController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text(AppUtils.getLocalizationContext(context)
                .main_view_nav_bar_home),
            activeColor: ColorConstants.colorE30404,
            inactiveColor: Colors.black),
        BottomNavyBarItem(
            icon: Icon(Icons.star),
            title: Text(AppUtils.getLocalizationContext(context)
                .main_view_nav_bar_wishlist),
            activeColor: ColorConstants.colorE30404,
            inactiveColor: Colors.black),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(AppUtils.getLocalizationContext(context)
                .main_view_nav_bar_profile),
            activeColor: ColorConstants.colorE30404,
            inactiveColor: Colors.black),
      ],
    );
  }
}
