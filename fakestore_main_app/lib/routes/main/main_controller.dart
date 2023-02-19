import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

enum MainViewTabIndex { home, wishlist, profile }

abstract class MainControllerInterface extends BaseController {
  late Rx<MainViewTabIndex> currentSelectedIndex;

  setSelectedTabIndex(int index);
  int getSelectedTabIndex();
}

class MainControllerImplementation extends MainControllerInterface {
  MainControllerImplementation() {
    currentSelectedIndex = MainViewTabIndex.home.obs;
  }

  @override
  setSelectedTabIndex(int index) {
    switch (index) {
      case 0:
        currentSelectedIndex.value = MainViewTabIndex.home;
        break;
      case 1:
        currentSelectedIndex.value = MainViewTabIndex.wishlist;
        break;
      case 2:
        currentSelectedIndex.value = MainViewTabIndex.profile;
        break;
      default:
        break;
    }
  }

  @override
  int getSelectedTabIndex() {
    switch (currentSelectedIndex.value) {
      case MainViewTabIndex.home:
        return 0;
      case MainViewTabIndex.wishlist:
        return 1;
      case MainViewTabIndex.profile:
        return 2;
    }
  }
}
