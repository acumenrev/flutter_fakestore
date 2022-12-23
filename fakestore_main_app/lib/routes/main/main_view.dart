import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_core_ui/fakestore_core_ui.dart';
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
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            _buildTopCategoryBar(),
            _buildContent()
          ],
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

  _buildContent() {
    return Container();
  }

  _buildHead() {
    return Container(
      height: 100,
      child: Expanded(
        child: Row(
          children: [],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  _buildBottomTabbar() {
    return Container();
  }
}
