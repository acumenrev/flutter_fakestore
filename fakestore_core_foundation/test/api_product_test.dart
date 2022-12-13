import 'dart:convert';
import 'package:fakestore_core_foundation/models/fs_category.dart';
import 'package:fakestore_core_foundation/models/fs_product.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_products.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';
import 'package:tf_framework/models/base_error.dart';
import 'package:tf_framework/models/base_model.dart';
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
    group("getProducts", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getProductAPI(
            APIProducts.getProducts, {"limit": 20, "offset": 0}).toString();
        mockedDataPath = "test/json/products/get_all_products.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCallProducts.getProducts(20, 0);
        expect(result != null, true);
        final List<FSProduct> list = result["data"];
        expect(list != null, true);
        expect(list.isEmpty, false);
        expect(list.length, 20);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.getProducts(20, 0);
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

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.getProducts(20, 0);
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
    group("getSingleProduct", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getProductAPI(
            APIProducts.getSingleProduct, {"productId": 1}).toString();
        mockedDataPath = "test/json/products/get_single_product.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        });

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.getSingleProduct(1);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 1);
        expect(
            list.title,
            "Fjallraven - Foldsack No. 1 Backpack, Fits 15 "
            "Laptops");
        expect(list.price, 109.95);
        expect(
            list.description,
            "Your perfect pack for everyday use and "
            "walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
        expect(list.category == FSProductCategory.men_clothing, true);
        expect(list.image,
            "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
        expect(list.rating != null, true);
        expect(list.rating?.count, 120);
        expect(list.rating?.rate, 3.9);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.getSingleProduct(1);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 0);
        expect(list.title, "");
        expect(list.price, 0);
        expect(list.description, "");
        expect(list.category == FSProductCategory.unknown, true);
        expect(list.image, "");
        expect(list.rating == null, true);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.getSingleProduct(1);
        expect(response != null, true);
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
    group("addProduct", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getProductAPI(APIProducts.addProduct, {}).toString();
        mockedDataPath = "test/json/products/add_product.json";
      });

      test("stub with success response", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.addProduct(inputData);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 1);
        expect(
            list.title,
            "Fjallraven - Foldsack No. 1 Backpack, Fits 15 "
            "Laptops");
        expect(list.price, 109.95);
        expect(
            list.description,
            "Your perfect pack for everyday use and "
            "walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
        expect(list.category == FSProductCategory.men_clothing, true);
        expect(list.image,
            "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
        expect(list.rating != null, true);
        expect(list.rating?.count, 120);
        expect(list.rating?.rate, 3.9);
      });

      test("stub with incorrect response", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.addProduct(inputData);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 0);
        expect(list.title, "");
        expect(list.price, 0);
        expect(list.description, "");
        expect(list.category == FSProductCategory.unknown, true);
        expect(list.image, "");
        expect(list.rating == null, true);
      });

      test("stub with server return error", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onPost(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.addProduct(inputData);
        expect(response != null, true);
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
    group("updateProduct", () {
      setUp(() async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        urlToMock = NetworkModule.shared.getProductAPI(
            APIProducts.updateProduct, {"product": inputData}).toString();
        mockedDataPath = "test/json/products/add_product.json";
      });

      test("stub with success response", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.updateProduct(inputData);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 1);
        expect(
            list.title,
            "Fjallraven - Foldsack No. 1 Backpack, Fits 15 "
            "Laptops");
        expect(list.price, 109.95);
        expect(
            list.description,
            "Your perfect pack for everyday use and "
            "walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday");
        expect(list.category == FSProductCategory.men_clothing, true);
        expect(list.image,
            "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg");
        expect(list.rating != null, true);
        expect(list.rating?.count, 120);
        expect(list.rating?.rate, 3.9);
      });

      test("stub with incorrect response", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.updateProduct(inputData);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 0);
        expect(list.title, "");
        expect(list.price, 0);
        expect(list.description, "");
        expect(list.category == FSProductCategory.unknown, true);
        expect(list.image, "");
        expect(list.rating == null, true);
      });

      test("stub with server return error", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onPut(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.updateProduct(inputData);
        expect(response != null, true);
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
    group("deleteProduct", () {
      setUp(() async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        urlToMock = NetworkModule.shared.getProductAPI(
            APIProducts.deleteProduct, {"product": inputData}).toString();
        mockedDataPath = "test/json/products/add_product.json";
      });

      test("stub with success response", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(200, null);
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.deleteProduct(inputData);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 0);
        expect(list.title, "");
        expect(list.price, 0);
        expect(list.description, "");
        expect(list.category == FSProductCategory.unknown, true);
        expect(list.image, "");
        expect(list.rating != null, false);
      });

      test("stub with incorrect response", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.deleteProduct(inputData);
        expect(response != null, true);
        final FSProduct list = response["data"];
        expect(list != null, true);
        expect(list.id, 0);
        expect(list.title, "");
        expect(list.price, 0);
        expect(list.description, "");
        expect(list.category == FSProductCategory.unknown, true);
        expect(list.image, "");
        expect(list.rating == null, true);
      });

      test("stub with server return error", () async {
        mockedDataPath = "test/json/products/get_single_product.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final inputData = FSProduct.fromJson(jsonDecode(data));
        dioAdapter.onDelete(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);

        final JSONData response =
            await NetworkModule.shared.apiCallProducts.deleteProduct(inputData);
        expect(response != null, true);
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
