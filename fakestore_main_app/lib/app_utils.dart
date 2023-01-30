import 'dart:ffi';

import 'package:fakestore_core_foundation/models/fs_order.dart';
import 'package:fakestore_main_app/constants/dotenv_constants.dart';
import 'package:fakestore_main_app/extensions/string_extension.dart';
import 'package:fakestore_main_app/main.dart';
import 'package:fakestore_main_app/routes/profile/orders/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map<String, String> appEnv = dotenv.env;

class AppUtils {
  AppUtils._();

  static final AppUtils shared = AppUtils._();

  static AppLocalizations getLocalizationContext(BuildContext context) {
    return AppLocalizations.of(context);
  }

  static viewImages(List<Image> images) {}

  static showSuccessToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showErrorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showWarning(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static String getProfileOrderString(
      BuildContext context, OrderStatus element) {
    String result = "";

    switch (element) {
      case OrderStatus.toPay:
        result = AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order_to_pay;
        break;
      case OrderStatus.toShip:
        result = AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order_to_ship;
        break;
      case OrderStatus.toReceive:
        result = AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order_to_receive;
        break;
      case OrderStatus.completed:
        result = AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order_complete;
        break;
      case OrderStatus.cancelled:
        result = AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order_cancelled;
        break;
      case OrderStatus.returnOrRefund:
        result = AppUtils.getLocalizationContext(context)
            .profile_profile_menu_order_return_refund;
        break;
    }
    return result;
  }

  static IconData getProfileOrderTabIcon(OrderStatus element) {
    switch (element) {
      case OrderStatus.toPay:
        return Icons.money_outlined;
      case OrderStatus.toShip:
        return Icons.delivery_dining_outlined;
      case OrderStatus.toReceive:
        return Icons.home_outlined;
      case OrderStatus.completed:
        return Icons.check_circle_outline;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
      case OrderStatus.returnOrRefund:
        return Icons.backspace_outlined;
    }
  }
}
