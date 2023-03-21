import 'package:fakestore_core_foundation/models/fs_product.dart';

import '../../../base/base_controller.dart';

abstract class ProductDetailControllerInterface extends BaseController {
  late FSProduct product;
}

class ProductDetailControllerImplementation
    extends ProductDetailControllerInterface {
  ProductDetailControllerImplementation({required FSProduct product}) {
    this.product = product;
  }
}
