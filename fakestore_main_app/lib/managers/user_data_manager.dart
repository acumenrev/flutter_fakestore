import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:get/get.dart';

class UserDataManager {
  static final UserDataManager shared = UserDataManager._();
  Rx<int> numberOfItemsInCart = 12.obs;
  Rx<FSUser?> currentUser = (null as FSUser?).obs;

  // private constructor
  UserDataManager._() {
    _initFakeUser();
  }

  _initFakeUser() {
    Map<String, dynamic> sampleJson = {
      "address": {
        "geolocation": {"lat": "-37.3159", "long": "81.1496"},
        "city": "kilcoole",
        "street": "new road",
        "number": 7682,
        "zipcode": "12926-3874"
      },
      "id": 1,
      "email": "john@gmail.com",
      "username": "johnd",
      "password": "m38rmF",
      "name": {"firstname": "john", "lastname": "doe"},
      "phone": "1-570-236-7033",
      "__v": 0
    };

    FSUser user = FSUser.fromJson(sampleJson);
    currentUser.value = user;
  }
}
