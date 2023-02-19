import 'dart:async';
import 'dart:math' as math show Random;

import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeControllerInterface extends BaseController {
  late RxList<FSProduct> products;
  late RxList<FSProductCategory> selectedCategories;
  void addOrRemoveCategory(FSProductCategory category);
  Future<void> getProducts();
}

class HomeControllerImplementation extends HomeControllerInterface {
  HomeControllerImplementation() {
    products = RxList.empty(growable: true);

    selectedCategories = RxList.empty(growable: true);
    isLoading.value = true;
    getProducts();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> getProducts() async {
    final result =
        await NetworkModule.shared.apiCallProducts.getProducts(20, 0);
    final List<FSProduct> list = result["data"];
    products.value = list;
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
}
