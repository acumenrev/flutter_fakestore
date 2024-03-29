import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tf_framework/models/base_model.dart';

void main() {
  group("test api", () {
    tearDown(() {
      String expectedResult = "fakestoreapi.com";
      NetworkModule.shared.setBaseUrl(expectedResult);
    });

    test("convert Map<String, dynamic> to Map<String, String>", () {
      JSONData query = {"limit": 10, "offset": 20, "sort": "asc"};
      QueryParams queryParams =
          NetworkModule.shared.convertMapStringDynamicToMapStringString(query);
      expect(queryParams["limit"], "10");
      expect(queryParams["offset"], "20");
      expect(queryParams["sort"], "asc");
    });

    test("test setup baseUrl", () {
      String expectedUrl = "google.com";
      NetworkModule.shared.setBaseUrl(expectedUrl);
      expect(NetworkModule.shared.getBaseUrl(), expectedUrl);
    });

    test("test initial base url", () {
      String expectedResult = "fakestoreapi.com";
      expect(NetworkModule.shared.getBaseUrl(), expectedResult);
    });
    test("test build api", () {
      String path = "/user";
      String expectedRoute = "https://fakestoreapi.com/user";
      String result = NetworkModule.shared.buildAPI(path: path).toString();
      expect(result, expectedRoute);
    });

    test("build api with params", () {
      String path = "/user";
      Map<String, dynamic> query = {"limit": 10, "offset": 20, "sort": "asc"};
      String expectedRoute =
          "https://fakestoreapi.com/user?limit=10&offset=20&sort=asc";
      String result = NetworkModule.shared
          .buildAPI(
              path: path,
              queryParams: NetworkModule.shared
                  .convertMapStringDynamicToMapStringString(query))
          .toString();
      expect(result, expectedRoute);
    });
  });
}
