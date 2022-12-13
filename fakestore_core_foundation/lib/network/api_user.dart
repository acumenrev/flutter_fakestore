import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:fakestore_core_foundation/network/api_call.dart';
import 'package:fakestore_core_foundation/network/api_cart.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

import 'api.dart';

enum APIUsers { getAllUsers, getASingleUser, addUser, updateUser, deleteUser }

// API extension for User
extension APIExtensionUser on NetworkModule {
  Uri getUserAPI(APIUsers api, JSONData data) {
    switch (api) {
      case APIUsers.getAllUsers:
        return _getAllUsers(data);
      case APIUsers.getASingleUser:
        return _getASingleUser(data);
      case APIUsers.addUser:
        return _addUser(data);
      case APIUsers.updateUser:
        return _updateUser(data);
      case APIUsers.deleteUser:
        return _deleteUser(data);
    }
  }

  _getAllUsers(JSONData data) {
    QueryParams params = {};
    if (data["limit"] != null) {
      params["limit"] = (data["limit"] ?? 10).toString();
    }

    if (data["sort"] != null) {
      params["sort"] = data["sort"] ?? "";
    }

    return buildAPI(path: "/users", queryParams: params);
  }

  _getASingleUser(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/users/$userId");
  }

  _addUser(JSONData data) {
    return buildAPI(path: "/users");
  }

  _updateUser(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/users/$userId");
  }

  _deleteUser(JSONData data) {
    int userId = data["userId"] ?? 0;
    return buildAPI(path: "/users/$userId");
  }
}

class APICallUsers extends APICall {
  /// Get All Users
  Future<JSONData> getAllUsers(int limit, String sort) async {
    List<FSUser> list = [];
    Uri url = NetworkModule.shared
        .getUserAPI(APIUsers.getAllUsers, {"limit": limit, "sort": sort});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    var decodedResponse = response.getDecodedJsonResponse();
    if (decodedResponse is List<dynamic>) {
      list.addAll(FSUser.parseFromList(decodedResponse));
    }

    return generateNetworkResponse(list, response.getError());
  }

  /// Get info for a user
  Future<JSONData> getAUser(int userId) async {
    FSUser? result;
    Uri url = NetworkModule.shared
        .getUserAPI(APIUsers.getASingleUser, {"userId": userId});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    var decodedResponse = response.getDecodedJsonResponse();
    result = FSUser.fromJson(decodedResponse);
    return generateNetworkResponse(result, response.getError());
  }

  /// Add a user
  Future<JSONData> addUser(FSUser data) async {
    FSUser? result;
    Uri url = NetworkModule.shared.getUserAPI(APIUsers.addUser, {});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.post,
            data: data.toJson());
    var decodedResponse = response.getDecodedJsonResponse();
    result = FSUser.fromJson(decodedResponse);
    return generateNetworkResponse(result, response.getError());
  }

  /// Update user
  Future<JSONData> updateUser(FSUser user) async {
    FSUser? result;
    Uri url = NetworkModule.shared
        .getUserAPI(APIUsers.updateUser, {"userId": user.id});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(
            path: url.toString(),
            method: TFHTTPMethod.put,
            data: user.toJson());
    var decodedResponse = response.getDecodedJsonResponse();
    result = FSUser.fromJson(decodedResponse);
    return generateNetworkResponse(result, response.getError());
  }

  /// delete user
  Future<JSONData> deteleUser(FSUser user) async {
    FSUser? result;
    Uri url = NetworkModule.shared
        .getUserAPI(APIUsers.deleteUser, {"userId": user.id});
    TFNetworkResponseModel response = await NetworkModule.shared
        .getHTTPClient()
        .fetch(path: url.toString(), method: TFHTTPMethod.delete);
    var decodedResponse = response.getDecodedJsonResponse();
    result = FSUser.fromJson(decodedResponse);
    return generateNetworkResponse(result, response.getError());
  }
}
