import 'package:get/get.dart';

class BaseController extends GetxController {
  late RxBool isLoading;
  BaseController() {
    isLoading = RxBool(false);
  }
}
