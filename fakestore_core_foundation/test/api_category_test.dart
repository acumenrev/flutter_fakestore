import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_category.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:tf_framework/models/base_error.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:dio/dio.dart';
import 'package:tf_framework/utils/tf_logger.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  String mockedDataPath = "";
  String urlToMock = "";

  setUp(() {
    NetworkModule.shared.getHTTPClient().setHttpClientAdapter(dioAdapter);
  });

  tearDownAll(() {
    NetworkModule.shared.getHTTPClient().setHttpClientAdapter(null);
  });

  group("construct api", () {
    tearDown(() {
      urlToMock = "";
    });

    test("getAllCategories", () {
      urlToMock = NetworkModule.shared
          .getCategoryAPI(APIProductCategories.getAllCategories, {}).toString();
      String expectedResult = "https://fakestoreapi.com/products/categories";
      expect(urlToMock, expectedResult);
    });
    test("getProductsInCategory", () {
      FSProductCategory category = FSProductCategory.electronics;
      String categoryName = stringFromProductCategory(category);
      urlToMock = NetworkModule.shared.getCategoryAPI(
          APIProductCategories.getProductsInCategory,
          {"category": category}).toString();
      String expectedResult =
          "https://fakestoreapi.com/products/category/$categoryName";
      expect(urlToMock, expectedResult);
    });
  });

  group("execute apis", () {
    group("getAllCategories", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getCategoryAPI(
            APIProductCategories.getAllCategories, {}).toString();
        mockedDataPath = "test/json/product_categories/get_all_categories.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCategories.getCategories();
        expect(result != null, true);
        final List<FSProductCategory> list = result["data"];
        expect(list != null, true);
        expect(list.isEmpty, false);
        expect(list.length, 4);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallCategories.getCategories();
        expect(response != null, true);
        final List<FSProductCategory> list = response["data"];
        expect(list != null, true);
        expect(list.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallCategories.getCategories();
        expect(response != null, true);
        List<FSProductCategory> list = response["data"];
        expect(list.isEmpty, true);
        TFError err = response["error"];
        expect(err != null, true);
        expect(err.statusCode, 500);
        expect(err.data != null, true);
        JSONData errorData = err.data;
        expect(errorData["message"], "error message");
      });

      tearDownAll(() {
        dioAdapter.reset();
        urlToMock = "";
      });
    });

    group("getProductsInCategory", () {
      setUp(() {
        FSProductCategory category = FSProductCategory.electronics;
        urlToMock = NetworkModule.shared.getCategoryAPI(
            APIProductCategories.getProductsInCategory,
            {"category": category}).toString();
        mockedDataPath =
            "test/json/product_categories/get_products_in_cart.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });
        final JSONData response = await NetworkModule.shared.apiCallCategories
            .getProductsInACategory(FSProductCategory.electronics);
        expect(response != null, true);
        final List<FSProduct> list = response["data"];
        expect(list != null, true);
        expect(list.isEmpty, false);
        expect(list.length, 6);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData response = await NetworkModule.shared.apiCallCategories
            .getProductsInACategory(FSProductCategory.electronics);
        expect(response != null, true);
        final List<FSProduct> list = response["data"];
        expect(list != null, true);
        expect(list.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        });

        final JSONData response = await NetworkModule.shared.apiCallCategories
            .getProductsInACategory(FSProductCategory.electronics);
        expect(response != null, true);
        List<FSProduct> list = response["data"];
        expect(list.isEmpty, true);
        TFError err = response["error"];
        expect(err != null, true);
        expect(err.statusCode, 500);
        expect(err.data != null, true);
        JSONData errorData = err.data;
        expect(errorData["message"], "error message");
      });

      tearDownAll(() {
        dioAdapter.reset();
        urlToMock = "";
      });
    });
  });
}
