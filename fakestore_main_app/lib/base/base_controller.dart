import 'package:get/get.dart';
import 'package:tf_framework/models/base_error.dart';

class BaseController extends GetxController {
  late RxBool isLoading;
  late Rx<TFError?> error;
  BaseController() {
    isLoading = RxBool(false);
    error = (null as TFError?).obs;
  }
}
