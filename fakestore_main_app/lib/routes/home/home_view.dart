import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key, required this.controller});

  late HomeControllerInterface controller;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    return Container(
      color: Colors.yellow,
    );
  }

  _buildTopCategoryBar() {
    return ScrollingButtonBar(
        children: [
          ButtonsItem(
              child: Container(
                child: const Text("Hello"),
              ),
              onTap: () {}),
          ButtonsItem(
              child: Container(
                child: const Text("TExt"),
              ),
              onTap: () {})
        ],
        childWidth: 200,
        childHeight: 60,
        foregroundColor: Colors.red,
        scrollController: _scrollController,
        selectedItemIndex: 0);
  }
}
