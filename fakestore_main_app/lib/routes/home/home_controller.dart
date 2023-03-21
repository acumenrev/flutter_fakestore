import 'dart:async';
import 'dart:math' as math show Random;

import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:fakestore_main_app/routes/wishlist/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeControllerInterface extends BaseController {
  late RxList<FSProduct> products;
  late RxList<FSProductCategory> selectedCategories;
  void addOrRemoveCategory(FSProductCategory category);
  Future<void> getProducts();
  void addOrRemoveItemInWishlist(FSProduct product, int index);
  Future<void> getMore();
  late int currentOffset;
  late final int listLimit;
  Future<void> refreshData();
  late bool canGetMore;
}

class HomeControllerImplementation extends HomeControllerInterface {
  HomeControllerImplementation() {
    products = RxList.empty(growable: true);

    selectedCategories = RxList.empty(growable: true);
    isLoading.value = true;
    currentOffset = 0;
    listLimit = 20;
    canGetMore = true;
    getProducts();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    debugPrint("onInit again");
  }

  @override
  Future<void> getProducts() async {
    final result = await NetworkModule.shared.apiCallProducts
        .getProducts(listLimit, currentOffset);
    final List<FSProduct> list = result["data"];
    if (currentOffset > 0) {
      // load more
      products.value.addAll(list);
    } else {
      // refresh
      products.value = list;
    }
    canGetMore = list.length >= listLimit;

    isLoading.value = false;
  }

  @override
  void addOrRemoveCategory(FSProductCategory category) {
    if (selectedCategories.contains(category) == true) {
      // remove
      selectedCategories.remove(category);
    } else {
      // add
      selectedCategories.add(category);
    }
  }

  @override
  void addOrRemoveItemInWishlist(FSProduct product, int index) {
    product.isFavorite = !product.isFavorite;
    FSProduct newProduct = FSProduct.fromJson(product.toJson());
    this.products[index] = newProduct;
    WishlistControllerInterface wlistController = Get.find();
    wlistController.addOrRemoveWishlistItem(newProduct);
  }

  @override
  Future<void> refreshData() async {
    currentOffset = 0;
    await getProducts();
  }

  @override
  Future<void> getMore() async {
    if (!canGetMore) {
      return;
    }
    currentOffset += listLimit;
    await getProducts();
    // fake to hide load more
    canGetMore = false;
  }
}
