import 'dart:async';
import 'dart:math' as math show Random;

import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeControllerInterface extends BaseController {
  late Rx<Color?> mainColor;
}

class HomeControllerImplementation extends HomeControllerInterface {
  @override
  Rx<Color?> mainColor = (null as Color?).obs;

  HomeControllerImplementation() {
    debugPrint("init home view model");
    Timer.periodic(const Duration(seconds: 1), (timer) {
      changeColor();
    });
  }

  changeColor() {
    final color =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    mainColor.value = color;
  }
}