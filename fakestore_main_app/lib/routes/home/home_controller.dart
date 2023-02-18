import 'dart:async';
import 'dart:math' as math show Random;

import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeControllerInterface extends BaseController {
  late Rx<Color?> mainColor;
  late RxList<FSProduct> products;
  late RxList<FSProductCategory> selectedCategories;

  void addOrRemoveCategory(FSProductCategory category) {}
}

class HomeControllerImplementation extends HomeControllerInterface {
  HomeControllerImplementation() {
    debugPrint("init home view model");
    Timer.periodic(const Duration(seconds: 1), (timer) {
      changeColor();
    });

    mainColor = (null as Color?).obs;
    products = RxList.empty(growable: true);
    selectedCategories = RxList.empty(growable: true);
  }

  changeColor() {
    final color =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    mainColor.value = color;
  }

  @override
  void addOrRemoveCategory(FSProductCategory category) {
    super.addOrRemoveCategory(category);
    if (selectedCategories.contains(category) == true) {
      // remove
      selectedCategories.remove(category);
    } else {
      // add
      selectedCategories.add(category);
    }
  }
}
