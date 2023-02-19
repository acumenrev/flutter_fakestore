// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:fakestore_core_foundation/network/api.dart';
import 'package:fakestore_core_foundation/network/api_user.dart';
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

    test("getAllUsers", () {
      urlToMock = NetworkModule.shared.getUserAPI(
          APIUsers.getAllUsers, {"limit": 5, "sort": "desc"}).toString();
      String expectedResult =
          "https://fakestoreapi.com/users?limit=5&sort=desc";
      expect(urlToMock, expectedResult);
    });

    test("getASingleUser", () {
      urlToMock = NetworkModule.shared
          .getUserAPI(APIUsers.getASingleUser, {"userId": 1}).toString();
      String expectedResult = "https://fakestoreapi.com/users/1";
      expect(urlToMock, expectedResult);
    });
    test("addUser", () async {
      urlToMock =
          NetworkModule.shared.getUserAPI(APIUsers.addUser, {}).toString();
      String expectedResult = "https://fakestoreapi.com/users";
      expect(urlToMock, expectedResult);
    });
    test("updateUser", () {
      urlToMock = NetworkModule.shared
          .getUserAPI(APIUsers.updateUser, {"userId": 1}).toString();
      String expectedResult = "https://fakestoreapi.com/users/1";
      expect(urlToMock, expectedResult);
    });
    test("deleteUser", () async {
      urlToMock = NetworkModule.shared
          .getUserAPI(APIUsers.deleteUser, {"userId": 1}).toString();
      String expectedResult = "https://fakestoreapi.com/users/1";
      expect(urlToMock, expectedResult);
    });
  });

  group("execute apis", () {
    group("getAllUsers", () {
      setUp(() {
        urlToMock = NetworkModule.shared.getUserAPI(
            APIUsers.getAllUsers, {"limit": 20, "sort": "desc"}).toString();
        mockedDataPath = "test/json/users/get_all_users.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        List<dynamic> listJson = List<dynamic>.from(jsonDecode(data));
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, listJson);
        });

        final JSONData response =
            await NetworkModule.shared.apiCallUsers.getAllUsers(20, "desc");
        final List<FSUser> list = response["data"];
        expect(list.isEmpty, false);
        expect(list.length, 10);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallUsers.getAllUsers(20, "desc");
        expect(response != null, true);
        final List<FSUser> list = response["data"];
        expect(list != null, true);
        expect(list.length, 0);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(500, {"message": "error message"});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallUsers.getAllUsers(20, "desc");
        expect(response != null, true);
        List<FSUser> list = response["data"];
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
    group("getSingleUser", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getUserAPI(APIUsers.getASingleUser, {"userId": 1}).toString();
        mockedDataPath = "test/json/users/get_a_user.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        });

        final JSONData response =
            await NetworkModule.shared.apiCallUsers.getAUser(1);
        expect(response != null, true);
        final FSUser result = response["data"];
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

      test("stub with incorrect response", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(200, {"status": 200});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallUsers.getAUser(1);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
      });

      test("stub with server return error", () async {
        dioAdapter.onGet(urlToMock, (server) {
          server.reply(500, {"message": "error message"});
        });

        final JSONData response =
            await NetworkModule.shared.apiCallUsers.getAUser(1);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
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
    group("addUser", () {
      setUp(() {
        urlToMock =
            NetworkModule.shared.getUserAPI(APIUsers.addUser, {}).toString();
        mockedDataPath = "test/json/users/add_user.json";
      });

      test("stub with success response", () async {
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);

        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.addUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 1);
      });

      test("stub with incorrect response", () async {
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);

        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.addUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
      });

      test("stub with server return error", () async {
        dioAdapter.onPost(urlToMock, (server) {
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);

        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.addUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
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
    group("updateUser", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getUserAPI(APIUsers.updateUser, {"userId": 1}).toString();
        mockedDataPath = "test/json/users/update_user.json";
      });

      test("stub with success response", () async {
        TFLogger.logger.d("URL to mock: $urlToMock");
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);
        mockedDataPath = "test/json/users/get_a_user.json";
        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.updateUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName != null, true);
        expect(result.fullName?.firstName, "John");
        expect(result.fullName?.lastName, "Doe");
        expect(result.email, "John@gmail.com");
        expect(result.username, "johnd");
        expect(result.password, "m38rmF\$");
        expect(result.phone, "1-570-236-7033");
        expect(result.address != null, true);
        expect(result.address?.geoLocation != null, true);
        expect(result.address?.geoLocation?.latitude, "-37.3159");
        expect(result.address?.geoLocation?.longitude, "81.1496");
        expect(result.address?.city, "kilcoole");
        expect(result.address?.street, "7835 new road");
        expect(result.address?.number, 3);
        expect(result.address?.zipcode, "12926-3874");
      });

      test("stub with incorrect response", () async {
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);
        mockedDataPath = "test/json/users/get_a_user.json";
        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.updateUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
      });

      test("stub with server return error", () async {
        dioAdapter.onPut(urlToMock, (server) {
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);
        mockedDataPath = "test/json/users/get_a_user.json";
        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.updateUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
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
    group("deleteUser", () {
      setUp(() {
        urlToMock = NetworkModule.shared
            .getUserAPI(APIUsers.deleteUser, {"userId": 1}).toString();
      });

      test("stub with success response", () async {
        mockedDataPath = "test/json/users/get_a_user.json";
        String data = await FSCoreUtils.loadJsonFile(mockedDataPath);
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(200, jsonDecode(data));
        }, data: Matchers.any);
        mockedDataPath = "test/json/users/delete_user.json";
        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.deleteUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
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

      test("stub with incorrect response", () async {
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(200, {"status": 200});
        }, data: Matchers.any);

        mockedDataPath = "test/json/users/delete_user.json";
        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.deleteUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
      });

      test("stub with server return error", () async {
        dioAdapter.onDelete(urlToMock, (server) {
          server.reply(500, {"message": "error message"});
        }, data: Matchers.any);

        mockedDataPath = "test/json/users/delete_user.json";
        String stringData = await FSCoreUtils.loadJsonFile(mockedDataPath);
        final FSUser inputData = FSUser.fromJson(jsonDecode(stringData));
        final JSONData response =
            await NetworkModule.shared.apiCallUsers.deleteUser(inputData);
        expect(response != null, true);
        final FSUser result = response["data"];
        expect(result != null, true);
        expect(result.id, 0);
        expect(result.fullName == null, true);
        expect(result.email, "");
        expect(result.username, "");
        expect(result.password, "");
        expect(result.phone, "");
        expect(result.address == null, true);
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
