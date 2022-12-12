import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_products.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';

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

    test("getProducts", () {
      urlToMock = NetworkModule.shared.getProductAPI(
          APIProducts.getProducts, {"limit": 5, "offset": 0}).toString();
      String expectedResult =
          "https://fakestoreapi.com/products?limit=5&offset=0";
      expect(urlToMock, expectedResult);
    });

    test("addProduct", () {
      urlToMock = NetworkModule.shared
          .getProductAPI(APIProducts.addProduct, {}).toString();
      String expectedResult = "https://fakestoreapi.com/products";
      expect(urlToMock, expectedResult);
    });
    test("deleteProduct", () async {
      mockedDataPath = "test/json/products/get_single_product.json";
      String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
      final inputData = FSProduct.fromJson(jsonDecode(data));
      urlToMock = NetworkModule.shared.getProductAPI(
          APIProducts.deleteProduct, {"product": inputData}).toString();
      String expectedResult = "https://fakestoreapi.com/products/1";
      expect(urlToMock, expectedResult);
    });
    test("getSingleProduct", () {
      urlToMock = NetworkModule.shared.getProductAPI(
          APIProducts.getSingleProduct, {"productId": 1}).toString();
      String expectedResult = "https://fakestoreapi.com/products/1";
      expect(urlToMock, expectedResult);
    });
    test("updateProduct", () async {
      mockedDataPath = "test/json/products/get_single_product.json";
      String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
      final inputData = FSProduct.fromJson(jsonDecode(data));
      urlToMock = NetworkModule.shared.getProductAPI(
          APIProducts.updateProduct, {"product": inputData}).toString();
      String expectedResult = "https://fakestoreapi.com/products/1";
      expect(urlToMock, expectedResult);
    });
  });

  group("execute apis", () {
    /*
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
    */
  });
}
