import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/routes/main/main_controller.dart';
import 'package:fakestore_main_app/routes/wishlist/wishlist_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/fs_product_thumbnail_tile.dart';

class WishlistView extends StatefulWidget {
  WishlistView({super.key, required this.controller});
  WishlistControllerInterface controller;

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
    widget.controller.getWishlist();
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

  Future<void> _onRefresh() async {}

  _buildContent(BuildContext ctx) {
    List<Widget> listWidget = [];
    FSProduct? element = null;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
                child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Obx(() {
                if (widget.controller.wishlistItems.isEmpty) {
                  return _buildEmptyPlaceholder(ctx);
                }
                return ListView.builder(
                  itemCount: widget.controller.wishlistItems.value.length,
                  itemBuilder: (context, index) {
                    element = widget.controller.wishlistItems.value[index];
                    return _buildItem(element!);
                  },
                );
              }),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPlaceholder(BuildContext ctx) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // text
              Text('It seems you do not have wishlist items'),
              // button to open discover
              CupertinoButton(
                  child: Container(
                    child: Text(
                      'Discover',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                        color: ColorConstants.colorE30404,
                        borderRadius: BorderRadius.circular(16.0)),
                  ),
                  onPressed: () {
                    _navigateToDiscover();
                  })
            ],
          ),
        ],
      ),
    );
  }

  // navigate to discover
  _navigateToDiscover() {
    MainControllerInterface mainController =
        Get.find<MainControllerInterface>();
    mainController.setSelectedTabIndex(0);
  }

  Widget _buildItem(FSProduct element) {
    return FSProductThumbnailTile(
      productImage: element!.image,
      title: element!.title,
      price: element!.price,
      productDesc: element!.description,
      isFavorite: element.isFavorite,
      rating: element.rating?.rate ?? 0,
      likeHandler: () {
        element.isFavorite = !element.isFavorite;
        widget.controller.addOrRemoveWishlistItem(element);
      },
      onTap: () {},
    );
  }
}
