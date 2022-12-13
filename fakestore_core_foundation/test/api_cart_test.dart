import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fakestore_core_foundation/models/fs_cart.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:tf_framework/models/base_error.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/utils/tf_logger.dart';

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  setUp(() {
    NetworkModule.shared.getHTTPClient().setHttpClientAdapter(dioAdapter);
  });

  tearDownAll(() {
    NetworkModule.shared.getHTTPClient().setHttpClientAdapter(null);
  });
  group("test build api", () {
    test("get all cart", () {
      Uri url = NetworkModule.shared.getCartsAPI(APICarts.getAllCarts, {});
      String expectedResult = "https://fakestoreapi.com/carts";
      expect(url.toString(), expectedResult);
    });

    test("get all cart with limit and offset", () {
      Uri url = NetworkModule.shared.getCartsAPI(APICarts.getAllCarts, {
        "limit": 10,
        "sort": "desc",
        "startdate": "2022-11-20",
        "enddate": "2022-11-23"
      });
      String expectedResult =
          "https://fakestoreapi.com/carts?limit=10&sort=desc&startdate=2022-11-20&enddate=2022-11-23";
      expect(url.toString(), expectedResult);
    });

    test("get user cart", () {
      Uri url =
          NetworkModule.shared.getCartsAPI(APICarts.getUserCart, {"userId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/user/1";
      expect(url.toString(), expectedResult);
    });
    test("get a single cart", () {
      Uri url = NetworkModule.shared
          .getCartsAPI(APICarts.getASingleCart, {"cartId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/1";
      expect(url.toString(), expectedResult);
    });

    test("add product to cart", () {
      Uri url = NetworkModule.shared.getCartsAPI(APICarts.addProductToCart, {});
      String expectedResult = "https://fakestoreapi.com/carts";
      expect(url.toString(), expectedResult);
    });

    test("update product to cart", () {
      Uri url = NetworkModule.shared
          .getCartsAPI(APICarts.updateProductInCart, {"cartId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/1";
      expect(url.toString(), expectedResult);
    });

    test("update product to cart with incorrect params", () {
      Uri url = NetworkModule.shared
          .getCartsAPI(APICarts.updateProductInCart, {"incorrect_params": 1});
      String expectedResult = "https://fakestoreapi.com/carts/0";
      expect(url.toString(), expectedResult);
    });

    test("delete product from cart", () {
      Uri url = NetworkModule.shared
          .getCartsAPI(APICarts.deleteProductFromCart, {"cartId": 1});
      String expectedResult = "https://fakestoreapi.com/carts/1";
      expect(url.toString(), expectedResult);
    });
  });
  group("test call api", () {
    String urlToMock = "";
    group("get all carts", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getCartsAPI(APICarts.getAllCarts, {}).toString();
      });

      test("stub with success response", () async {
        String mockedPath = "test/json/carts/get_all_carts.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCarts.getAllCarts();
        expect(result != null, true);
        final List<FSCart> list = result["data"];
        expect(list != null, true);
        expect(list.isEmpty, false);
        expect(list.length, 7);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCarts.getAllCarts();
        expect(result != null, true);
        final List<FSCart> list = result["data"];
        expect(list != null, true);
        expect(list.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        });

        final response = await NetworkModule.shared.apiCallCarts.getAllCarts();
        expect(response != null, true);
        List<FSCart> list = response["data"];
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
    group("get user carts", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getCartsAPI(APICarts.getUserCart,
            {"userId": 1, "limit": 5, "sort": "desc"}).toString();
      });

      test("stub with success response", () async {
        String mockedPath = "test/json/carts/get_user_carts.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCarts.getUserCarts(userId: 1);

        expect(result != null, true);
        final List<FSCart> list = result["data"];
        expect(list != null, true);
        expect(list.isEmpty, false);
        expect(list.length, 2);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCarts.getUserCarts(userId: 1);
        expect(result != null, true);
        final List<FSCart> list = result["data"];
        expect(list != null, true);
        expect(list.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        });

        final response =
            await NetworkModule.shared.apiCallCarts.getUserCarts(userId: 1);
        expect(response != null, true);
        List<FSCart> list = response["data"];
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
    group("get single cart", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getCartsAPI(APICarts.getASingleCart, {"cartId": 5}).toString();
      });

      test("stub with success response", () async {
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);

        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCarts.getSingleCart(5);

        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 5);
        expect(cart.userId, 3);
        expect(cart.date, "2020-03-01T00:00:02.000Z");
        expect(cart.products.isNotEmpty, true);
        expect(cart.products.length, 2);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData result =
            await NetworkModule.shared.apiCallCarts.getSingleCart(5);
        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        });

        final response =
            await NetworkModule.shared.apiCallCarts.getSingleCart(5);
        expect(response != null, true);
        final FSCart cart = response["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
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
    group("update cart", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getCartsAPI(
            APICarts.updateProductInCart, {"cartId": 5}).toString();
      });

      test("stub with success response", () async {
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);

        final JSONData result = await NetworkModule.shared.apiCallCarts
            .updateProductsInCart(inputData);

        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 5);
        expect(cart.userId, 3);
        expect(cart.date, "2020-03-01T00:00:02.000Z");
        expect(cart.products.isNotEmpty, true);
        expect(cart.products.length, 2);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);
        String mockedPath = "test/json_carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        final JSONData result = await NetworkModule.shared.apiCallCarts
            .updateProductsInCart(inputData);
        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onPut(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);
        String mockedPath = "test/json_carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        final response = await NetworkModule.shared.apiCallCarts
            .updateProductsInCart(inputData);
        expect(response != null, true);
        final FSCart cart = response["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
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
    group("delete cart", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getCartsAPI(
            APICarts.deleteProductFromCart, {"cartId": 5}).toString();
        TFLogger.logger.d("Url To Mock: $urlToMock");
      });

      test("stub with success response", () async {
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);

        final JSONData result = await NetworkModule.shared.apiCallCarts
            .deleteProductsInCart(inputData);

        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 5);
        expect(cart.userId, 3);
        expect(cart.date, "2020-03-01T00:00:02.000Z");
        expect(cart.products.isNotEmpty, true);
        expect(cart.products.length, 2);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        final JSONData result = await NetworkModule.shared.apiCallCarts
            .deleteProductsInCart(inputData);
        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onDelete(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        final response = await NetworkModule.shared.apiCallCarts
            .deleteProductsInCart(inputData);
        expect(response != null, true);
        final FSCart cart = response["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
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
    group("add product cart", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getCartsAPI(APICarts.addProductToCart, {}).toString();
        TFLogger.logger.d("Url To Mock: $urlToMock");
      });

      test("stub with success response", () async {
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);

        final JSONData result = await NetworkModule.shared.apiCallCarts
            .addProductsToCart(inputData);

        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 5);
        expect(cart.userId, 3);
        expect(cart.date, "2020-03-01T00:00:02.000Z");
        expect(cart.products.isNotEmpty, true);
        expect(cart.products.length, 2);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        final JSONData result = await NetworkModule.shared.apiCallCarts
            .addProductsToCart(inputData);
        expect(result != null, true);
        final FSCart cart = result["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onPost(urlToMock, (server) {
          final requestOptions = RequestOptions(path: urlToMock);
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);
        String mockedPath = "test/json/carts/get_single_cart.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        final inputData = FSCart.fromJson(jsonDecode(data));
        final response = await NetworkModule.shared.apiCallCarts
            .addProductsToCart(inputData);
        expect(response != null, true);
        final FSCart cart = response["data"];
        expect(cart != null, true);
        expect(cart.id, 0);
        expect(cart.userId, 0);
        expect(cart.date, "");
        expect(cart.products.length, 0);
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
