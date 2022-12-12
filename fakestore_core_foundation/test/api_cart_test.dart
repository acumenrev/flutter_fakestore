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

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  setUp(() {
    NetworkModule.shared.getHTTPClient().setHttpClientAdapter(dioAdapter);
  });

  tearDownAll(() {});
  group("test build api", () {
    test("get all cart", () {
      Uri url = NetworkModule.shared.getCartsAPI(APICarts.getAllCarts, {});
      String expectedResult = "https://fakestoreapi.com/carts";
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
        String mockedPath = "test/json_carts/get_all_carts.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCarts.getAllCarts();
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
            await NetworkModule.shared.apiCarts.getAllCarts();
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

        final response = await NetworkModule.shared.apiCarts.getAllCarts();
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
        String mockedPath = "test/json_carts/get_user_carts.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCarts.getUserCarts(userId: 1);

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
            await NetworkModule.shared.apiCarts.getUserCarts(userId: 1);
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
            await NetworkModule.shared.apiCarts.getUserCarts(userId: 1);
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
        urlToMock = NetworkModule.shared.getCartsAPI(APICarts.getASingleCart,
            {"userId": 1, "limit": 5, "sort": "desc"}).toString();
      });

      test("stub with success response", () async {
        String mockedPath = "test/json_carts/get_user_carts.json";
        String data = await FSCoreUtils.loadJsonFile(mockedPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData result =
            await NetworkModule.shared.apiCarts.getUserCarts(userId: 1);

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
            await NetworkModule.shared.apiCarts.getUserCarts(userId: 1);
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
            await NetworkModule.shared.apiCarts.getUserCarts(userId: 1);
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
  });
}
