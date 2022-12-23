import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.controller});

  late HomeControllerInterface controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
}
