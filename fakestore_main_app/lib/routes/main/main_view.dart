import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_core_ui/fakestore_core_ui.dart';
import 'package:fakestore_main_app/constants/font_constants.dart';
import 'package:fakestore_main_app/managers/user_data_manager.dart';
import 'package:flutter/material.dart';

import 'main_controller.dart';

class MainView extends StatefulWidget {
  MainView({super.key, required this.controller});

  late MainControllerInterface controller;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    //   return Scaffold(
    //     body: Container(
    //       child: Column(
    //         children: [_buildTopCategoryBar(), _buildContent()],
    //       ),
    //     ),
    //   );
    // });
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
            ],
          ),
        ),
      ),
    );
  }

  _buildTopCategoryBar() {
    return ScrollingButtonBar(
        children: [
          ButtonsItem(
              child: Container(
                child: Text("Hello"),
              ),
              onTap: () {}),
          ButtonsItem(
              child: Container(
                child: Text("TExt"),
              ),
              onTap: () {})
        ],
        childWidth: 200,
        childHeight: 60,
        foregroundColor: Colors.red,
        scrollController: _scrollController,
        selectedItemIndex: 0);
  }

  _buildTopButtonItems() {}

  _buildContent() {
    return Container();
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
                "Fashion",
                style: TextStyle(
                    fontFamily: FontConstants.getFont(
                        fontName: AppFonts.Rubik_Gemstones),
                    fontSize: 30),
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

  _buildBottomTabbar() {
    return Container();
  }
}
