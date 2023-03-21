import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_main_app/base/base_controller.dart';
import 'package:get/get.dart';

abstract class WishlistControllerInterface extends BaseController {
  late RxList<FSProduct> wishlistItems;
  Future<void> getWishlist();
  void addOrRemoveWishlistItem(FSProduct element);
}

class WishlistControllerImplementation extends WishlistControllerInterface {
  WishlistControllerImplementation() {
    wishlistItems = RxList.empty(growable: true);
  }

  @override
  Future<void> getWishlist() async {
    /*
    FSProduct product = FSProduct.fromJson({
      "id": 1,
      "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
      "price": 109.95,
      "description":
          "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      "rating": {"rate": 3.9, "count": 120}
    });
    wishlistItems.add(product);

     */
  }

  @override
  void addOrRemoveWishlistItem(FSProduct product) {
    int index = wishlistItems.indexWhere((element) {
      if (product.id == element.id) {
        return true;
      }
      return false;
    });

    if (index >= 0) {
      wishlistItems.removeAt(index);
    } else {
      wishlistItems.add(product);
    }
  }
}
