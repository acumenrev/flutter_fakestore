import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("fs_product_test", () {
    test("init from valid json", () async {
      String mockedDataPath = "test/json/users/get_a_user.json";
      String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
      final result = FSUser.fromJson(jsonDecode(data));
      expect(result != null, true);
      expect(result.id, 1);
      expect(result.fullName != null, true);
      expect(result.fullName?.firstName, "john");
      expect(result.fullName?.lastName, "doe");
      expect(result.email, "john@gmail.com");
      expect(result.username, "johnd");
      expect(result.password, "m38rmF\$");
      expect(result.phone, "1-570-236-7033");
      expect(result.address != null, true);
      expect(result.address?.geoLocation != null, true);
      expect(result.address?.geoLocation?.latitude, "-37.3159");
      expect(result.address?.geoLocation?.longitude, "81.1496");
      expect(result.address?.city, "kilcoole");
      expect(result.address?.street, "new road");
      expect(result.address?.number, 7682);
      expect(result.address?.zipcode, "12926-3874");
    });
    test("init from invalid json", () {
      final FSUser result = FSUser.fromJson({"message": "ok"});
      expect(result != null, true);
      expect(result.id, 0);
      expect(result.fullName == null, true);
      expect(result.email, "");
      expect(result.username, "");
      expect(result.password, "");
      expect(result.phone, "");
      expect(result.address == null, true);
    });
    test("init from null json", () {
      final FSUser result = FSUser.fromJson(null);
      expect(result != null, true);
      expect(result.id, 0);
      expect(result.fullName == null, true);
      expect(result.email, "");
      expect(result.username, "");
      expect(result.password, "");
      expect(result.phone, "");
      expect(result.address == null, true);
    });

    group("parse list json", () {
      test("init with empty aray", () {
        List<FSUser> list = FSUser.parseFromList(null);
        expect(list.isEmpty, true);
        List<FSUser> list2 = FSUser.parseFromList([]);
        expect(list.isEmpty, true);
      });

      test("init with aray", () async {
        String mockedPath = "test/json/users/get_all_users.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));

        List<FSUser> list = FSUser.parseFromList(listJson);
        expect(list.isEmpty, false);
        expect(list.length, 10);
      });
    });
  });
}
