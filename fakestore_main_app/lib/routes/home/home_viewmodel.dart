import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomeViewModel {
  Color? mainColor;

  HomeViewModel() {
    debugPrint("init home view model");
    Timer.periodic(const Duration(seconds: 1), (timer) {
      changeColor();
    });
  }

  changeColor() {
    mainColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
