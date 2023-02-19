import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_main_app/routes/wishlist/wishlist_controller.dart';
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
