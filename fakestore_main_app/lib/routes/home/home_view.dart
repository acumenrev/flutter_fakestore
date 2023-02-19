import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_ui/core_ui/fs_scrolling_button_bar.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/routes/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_utils.dart';
import 'fs_product_thumbnail_tile.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key, required this.controller});
  late HomeControllerInterface controller;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setupObservers();
  }

  _setupObservers() {
    widget.controller.selectedCategories.stream.listen((event) {
      widget.controller.isLoading.value = true;
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        setState(() {
          widget.controller.isLoading.value = false;
        });
      });
    });
  }

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
    list.add(Obx(() {
      return widget.controller.isLoading.isTrue
          ? Container(
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
            )
          : SizedBox(height: 0, width: 0);
    }));

    return list;
  }

  _buildContent(BuildContext ctx) {
    List<Widget> listWidget = [];
    FSProduct? element = null;
    return Container(
      child: Column(
        children: [
          _buildScrollingMenu(ctx),
          Expanded(
            child: Scrollbar(
                child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Obx(() {
                return ListView.builder(
                  itemCount: widget.controller.products.value.length,
                  itemBuilder: (context, index) {
                    element = widget.controller.products.value[index];
                    return _filterProduct(element!);
                  },
                );
              }),
            )),
          ),
        ],
      ),
    );
  }

  Widget _filterProduct(FSProduct element) {
    bool canReturn = true;

    if (widget.controller.selectedCategories.isNotEmpty) {
      if (element.category != null &&
          !widget.controller.selectedCategories.value
              .contains(element.category)) {
        canReturn = false;
      }
    }
    if (!canReturn) {
      return SizedBox(height: 0, width: 0);
    }

    return FSProductThumbnailTile(
      productImage: element!.image,
      title: element!.title,
      price: element!.price,
      productDesc: element!.description,
      onTap: () {},
      isFavorite: element.isFavorite,
      rating: element.rating?.rate ?? 0,
      likeHandler: () {
        // add to wish list
        setState(() {});
        widget.controller.addOrRemoveItemInWishlist(element);
      },
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
      temp = _horizontalButton(ctx, tabWidth, element, () {
        widget.controller.addOrRemoveCategory(element);
      });
      listWidget.add(temp!);
      listWidget.add(SizedBox(
        width: 15.0,
      ));
    }
    return listWidget;
  }

  Widget _horizontalButton(BuildContext ctx, double tabWidth,
      FSProductCategory element, VoidCallback onTap) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () {
        onTap();
      },
      child: Container(
        width: tabWidth,
        decoration: BoxDecoration(
            color: widget.controller.selectedCategories.contains(element)
                ? ColorConstants.colorE30404
                : Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
                color: widget.controller.selectedCategories.contains(element)
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
                      color:
                          widget.controller.selectedCategories.contains(element)
                              ? Colors.white
                              : Colors.black,
                      fontWeight:
                          widget.controller.selectedCategories.contains(element)
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

  Future<void> _onRefresh() async {
    await widget.controller.getProducts();
  }
}
