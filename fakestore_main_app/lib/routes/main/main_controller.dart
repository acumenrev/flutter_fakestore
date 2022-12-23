import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

enum MainViewTabIndex { home, wishlist, profile }

abstract class MainControllerInterface extends BaseController {
  late Rx<MainViewTabIndex> currentSelectedIndex;
}

class MainControllerImplementation extends MainControllerInterface {
  @override
  Rx<MainViewTabIndex> currentSelectedIndex = MainViewTabIndex.home.obs;
}
