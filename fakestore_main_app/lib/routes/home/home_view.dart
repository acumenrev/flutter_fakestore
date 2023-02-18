import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_utils.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key, required this.controller});
  late HomeControllerInterface controller;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: _buildMainStackViewChildren(context),
        ),
      ),
    );
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
    return Padding(
      padding:
          const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 0.0, right: 0.0),
      child: Container(
          height: 40,
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: _buildHorizontalItems(ctx),
                  );
                }),
              )
            ],
          )),
    );
  }

  _buildHorizontalItems(BuildContext ctx) {
    Widget? temp;
    double tabWidth = MediaQuery.of(ctx).size.width / 3;
    String buttonText = "";
    List<Widget> listWidget = [];
    listWidget.add(SizedBox(
      width: 15.0,
    ));
    for (var element in FSProductCategory.values) {
      temp = CupertinoButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          controller.addOrRemoveCategory(element);
        },
        child: Container(
          width: tabWidth,
          decoration: BoxDecoration(
              color: controller.selectedCategories.contains(element)
                  ? ColorConstants.colorE30404
                  : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                  color: controller.selectedCategories.contains(element)
                      ? Colors.white
                      : Colors.black)),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    _getTabContent(ctx, element),
                    style: TextStyle(
                        fontSize: 16,
                        color: controller.selectedCategories.contains(element)
                            ? Colors.white
                            : Colors.black,
                        fontWeight:
                            controller.selectedCategories.contains(element)
                                ? FontWeight.bold
                                : FontWeight.normal,
                        decoration: TextDecoration.none),
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      );
      listWidget.add(temp!);
      listWidget.add(SizedBox(
        width: 15.0,
      ));
    }
    return listWidget;
  }

  String _getTabContent(BuildContext context, FSProductCategory category) {
    switch (category) {
      case FSProductCategory.electronics:
        return AppUtils.getLocalizationContext(context)
            .home_category_electronics;
      case FSProductCategory.jewelry:
        return AppUtils.getLocalizationContext(context).home_category_jewelry;
      case FSProductCategory.men_clothing:
        return AppUtils.getLocalizationContext(context)
            .home_category_men_clothing;
      case FSProductCategory.women_clothing:
        return AppUtils.getLocalizationContext(context)
            .home_category_women_clothing;
      case FSProductCategory.unknown:
        return AppUtils.getLocalizationContext(context).home_category_unknown;
    }
  }
}
