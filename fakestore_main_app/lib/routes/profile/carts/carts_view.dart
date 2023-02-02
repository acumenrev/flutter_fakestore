import 'package:fakestore_main_app/routes/profile/carts/cart_item_view.dart';
import 'package:fakestore_main_app/routes/profile/carts/carts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../app_utils.dart';
import '../../../constants/color_constants.dart';
import '../../../ui/app_ios_navigation_bar.dart';

class CartsView extends StatelessWidget {
  CartsView({Key? key, required CartsControllerInterface controller}) {
    this.controller = controller;
  }
  late CartsControllerInterface controller;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: FSIOSNavigationBar.create(
          middleText: AppUtils.getLocalizationContext(context).user_carts,
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
                        controller.isEdit.toggle();
                      },
                      child: Obx(() {
                        return Text(
                          controller.isEdit.isTrue
                              ? AppUtils.getLocalizationContext(context)
                                  .user_carts_done
                              : AppUtils.getLocalizationContext(context)
                                  .user_carts_edit,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              color: ColorConstants.colorE30404),
                        );
                      }),
                    )),
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
    List<Widget> listWidget = [CartItemView()];
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

  _buildScrollingMenu(BuildContext ctx) {
    return Container(
        height: 50,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buildHorizontalItems(
                      ctx, controller.currentSelectedTab.value),
                );
              }),
            ),
            Container(
              height: 1,
              color: Colors.black12,
            )
          ],
        ));
  }

  _buildHorizontalItems(BuildContext ctx, UserCartsTabs currentSelectedTab) {
    Widget? temp;
    double tabWidth = MediaQuery.of(ctx).size.width / 3;
    String buttonText = "";
    List<Widget> listWidget = [];
    for (var element in UserCartsTabs.values) {
      temp = CupertinoButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          controller.currentSelectedTab.value = element;
          // _scrollViewJumpToItem(element.index, ctx);
        },
        child: Container(
          width: tabWidth,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    _getTabContent(ctx, element),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: currentSelectedTab == element
                            ? FontWeight.bold
                            : FontWeight.normal,
                        decoration: TextDecoration.none),
                    maxLines: 1,
                  ),
                ),
              ),
              // underline
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: currentSelectedTab == element ? tabWidth : 0,
                color: ColorConstants.colorE30404,
              )
            ],
          ),
        ),
      );
      listWidget.add(temp!);
    }
    return listWidget;
  }

  String _getTabContent(BuildContext ctx, UserCartsTabs tab) {
    switch (tab) {
      case UserCartsTabs.all:
        return AppUtils.getLocalizationContext(ctx).user_carts_all;
      case UserCartsTabs.discount:
        return AppUtils.getLocalizationContext(ctx).user_carts_discount;
      case UserCartsTabs.buyAgain:
        return AppUtils.getLocalizationContext(ctx).user_carts_buy_again;
    }
  }
}
