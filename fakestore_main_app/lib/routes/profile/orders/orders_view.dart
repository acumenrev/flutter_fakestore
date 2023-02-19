import 'dart:async';

import 'package:fakestore_core_foundation/models/fs_order.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/routes/profile/orders/order_tile.dart';
import 'package:fakestore_main_app/routes/profile/orders/orders_controller.dart';
import 'package:fakestore_main_app/routes/profile/orders/orders_search_bar_delegate.dart';
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
  static const double _padding = 8.0;

  _checkFirstLaunch(BuildContext ctx) {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollViewJumpToItem(controller.currentSelectedTab.value.index, ctx);
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkFirstLaunch(context);
    return CupertinoPageScaffold(
      navigationBar: FSIOSNavigationBar.create(
          middleText: AppUtils.getLocalizationContext(context).orders,
          trailing: _navBarTrailingWidget(context),
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

  Widget _navBarTrailingWidget(BuildContext context) {
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
                      onPressed: () {
                        _searchTap(context);
                      },
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

  void _searchTap(BuildContext context) {
    debugPrint("_searchTap");
    showSearch(
        context: context,
        // delegate to customize the search bar
        delegate: OrdersSearchDelegate());
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
    List<Widget> listWidget = [OrderTile(), OrderTile(), OrderTile()];
    return Container(
      child: Column(
        children: [
          _buildScrollingMenu(ctx),
          Expanded(
            child: Scrollbar(
              child: ListView(
                children: listWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _scrollViewJumpToItem(int index, BuildContext ctx) {
    final width =
        _scrollController.position.maxScrollExtent + (ctx.size?.width ?? 0);
    final value = (index / OrderStatus.values.length) * width - _padding * 2;
    final valueSpace = value + _padding;
    final newValue = valueSpace > _scrollController.position.maxScrollExtent
        ? _scrollController.position.maxScrollExtent
        : valueSpace;
    _scrollController.animateTo(newValue,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  _buildHorizontalItems(BuildContext ctx, OrderStatus currentSelectedTab) {
    Widget? temp;
    String buttonText = "";
    List<Widget> listWidget = [];
    for (var element in OrderStatus.values) {
      temp = CupertinoButton(
        onPressed: () {
          controller.currentSelectedTab.value = element;
          _scrollViewJumpToItem(element.index, ctx);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: _padding, right: _padding),
          child: Container(
            height: 40,
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    AppUtils.getProfileOrderString(ctx, element),
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: currentSelectedTab == element
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: TextDecoration.none),
                    maxLines: 1,
                  ),
                ),
                // underline
                Container(
                  height: 1,
                  width: 50,
                  color: currentSelectedTab == element
                      ? Colors.red
                      : Colors.transparent,
                )
              ],
            ),
          ),
        ),
      );
      listWidget.add(temp!);
    }
    return listWidget;
  }

  _buildScrollingMenu(BuildContext ctx) {
    return Container(
        height: 50,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    return Row(
                      children: _buildHorizontalItems(
                          ctx, controller.currentSelectedTab.value),
                    );
                  })),
            ),
            Container(
              height: 1,
              color: Colors.black12,
            )
          ],
        ));
  }
}
