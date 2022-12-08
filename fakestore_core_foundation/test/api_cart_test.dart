import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fakestore_core_foundation/models/fs_cart.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:fakestore_core_foundation/others/fs_core_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
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
        List<JSONData> listJson = List<JSONData>.from(jsonDecode(data));

        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final List<FSCart> result =
            await NetworkModule.shared.apiCarts.getAllCarts();
        expect(result.isEmpty, false);
        expect(result.length, 7);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final List<FSCart> result =
            await NetworkModule.shared.apiCarts.getAllCarts();
        expect(result.isEmpty, true);
        expect(result.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          // server.throws(
          //     500,
          //     new DioError(
          //         requestOptions: RequestOptions(
          //       path: urlToMock,
          //     )));
          server.reply(500, {"message": "error"});
        });
        final List<FSCart> result =
            await NetworkModule.shared.apiCarts.getAllCarts();
        expect(result.isEmpty, true);
        expect(result.length, 0);
      });

      tearDownAll(() {
        dioAdapter.reset();
        urlToMock = "";
      });
    });
  });
}
