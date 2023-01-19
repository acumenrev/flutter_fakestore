import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/routes/profile/orders/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../app_utils.dart';
import '../../../ui/app_ios_navigation_bar.dart';

class ProfileOrders extends StatelessWidget {
  ProfileOrders(
      {Key? key, required ProfileOrdersControllerInterface controller}) {
    this.controller = controller;
  }
  ScrollController _scrollController = ScrollController();
  late BuildContext ctx;
  late ProfileOrdersControllerInterface controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: FSIOSNavigationBar.create(
          middleText: AppUtils.getLocalizationContext(context).orders,
          trailing: _navBarTrailingWidget(),
          backButtonPressed: () {
            context.pop();
          }),
      child: SafeArea(
        child: Stack(
          children: _buildMainStackViewChildren(context),
        ),
      ),
    );
  }

  Widget _navBarTrailingWidget() {
    return Container(
        width: 90,
        color: Colors.transparent,
        child: Stack(
          children: [
            Row(
              children: [
                // search icon
                Container(
                  width: 40,
                  child: CupertinoButton(
                      padding: EdgeInsets.only(top: 0),
                      onPressed: _searchTap,
                      child: Icon(
                        CupertinoIcons.search,
                        color: ColorConstants.colorE30404,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                // messages
                Stack(
                  children: [
                    // icon
                    Container(
                      width: 40,
                      child: CupertinoButton(
                          padding: EdgeInsets.only(top: 0),
                          child: Icon(CupertinoIcons.chat_bubble_2,
                              color: ColorConstants.colorE30404),
                          onPressed: _unreadMessagesTap),
                    ),
                    // number
                    Positioned(
                      child: Container(
                        width: 22,
                        height: 22,
                        child: Center(child: Obx(() {
                          return Text(
                            controller.unreadMessages.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          );
                        })),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                      right: 0,
                      top: 0,
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }

  void _searchTap() {
    debugPrint("_searchTap");
  }

  void _unreadMessagesTap() {
    debugPrint("_unreadMessagesTap");
  }

  List<Widget> _buildMainStackViewChildren(BuildContext ctx) {
    List<Widget> list = [];
    list.add(_buildContent(ctx));
    if (controller.isLoading.isTrue) {
      list.add(Container(
        child: Stack(
          children: [
            // black background
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            // circular progress indicator
            Center(
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ),
      ));
    }

    return list;
  }

  _buildContent(BuildContext ctx) {
    List<Widget> listWidget = [];
    return Container(
      child: Column(
        children: [
          _buildScrollingMenu(ctx),
          Expanded(
            child: ListView(
              children: listWidget,
            ),
          ),
        ],
      ),
    );
  }

  _buildHorizontalItems(BuildContext ctx, ProfileOrdersTab currentSelectedTab) {
    Widget? temp;
    String buttonText = "";
    List<Widget> listWidget = [];
    for (var element in ProfileOrdersTab.values) {
      temp = Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          height: 40,
          child: Column(
            children: [
              Text(
                AppUtils.getProfileOrderString(ctx, element),
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
                maxLines: 1,
              ),
              // underline
              Container(
                height: 1,
                color: Colors.red,
              )
            ],
          ),
        ),
      );
      listWidget.add(temp!);
    }
    return listWidget;
  }

  _buildScrollingMenu(BuildContext ctx) {
    return Container(
        height: 60,
        color: Colors.transparent,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              return Row(
                children: _buildHorizontalItems(
                    ctx, controller.currentSelectedTab.value),
              );
            })));
  }
}
