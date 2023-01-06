import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';

class FSIOSNavigationBar {
  static CupertinoNavigationBar create(
      {required String middleText,
      required VoidCallback backButtonPressed,
      String backButtonText = ""}) {
    return CupertinoNavigationBar(
      middle: Text(
        middleText,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.colorE30404,
            fontSize: 20),
      ),
      leading: CupertinoNavigationBarBackButton(
        onPressed: () {
          backButtonPressed();
        },
        previousPageTitle: backButtonText,
        color: ColorConstants.colorE30404,
      ),
    );
  }
}
