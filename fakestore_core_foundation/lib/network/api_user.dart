import 'package:fakestore_core_foundation/models/fs_user.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/models/tf_network_response_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

import 'api.dart';

enum _APIUsers { getAllUsers, getASingleUser, addUser, updateUser, deleteUser }

// API extension for User
extension APIExtensionUser on API {
  Uri getUserAPI(_APIUsers api, JSONData data) {
    switch (api) {
      case _APIUsers.getAllUsers:
        return _getAllUsers(data);
      case _APIUsers.getASingleUser:
        return _getASingleUser(data);
      case _APIUsers.addUser:
        return _addUser(data);
      case _APIUsers.updateUser:
        return _updateUser(data);
      case _APIUsers.deleteUser:
        return _deleteUser(data);
    }
  }

  _getAllUsers(JSONData data) {
    int limit = data["limit"] ?? 0;
    String sort = data["sort"];

    return buildAPI(
        path: "/users", queryParams: {"limit": limit.toString(), "sort": sort});
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

class APICallUsers {
  /// Get All Users
  getAllUsers(int limit, int offset) async {
    List<FSUser> list = [];
    Uri url = API.shared
        .getUserAPI(_APIUsers.getAllUsers, {"limit": limit, "offset": offset});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    list.addAll(FSUser.parseFromList(response.getResponse().data));
    return list;
  }

  /// Get info for a user
  getAUser(int userId) async {
    FSUser? result;
    Uri url =
        API.shared.getUserAPI(_APIUsers.getASingleUser, {"userId": userId});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.get);
    result = FSUser.fromJson(response.getResponse().data);
    return result;
  }

  /// Add a user
  addUser(JSONData data) async {
    FSUser? result;
    Uri url = API.shared.getUserAPI(_APIUsers.getASingleUser, {});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.post, data: data);
    result = FSUser.fromJson(response.getResponse().data);
    return result;
  }

  /// Update user
  updateUser(FSUser user) async {
    FSUser? result;
    Uri url = API.shared.getUserAPI(_APIUsers.updateUser, {"userId": user.id});
    TFNetworkResponseModel response = await TFHTTPClient.shared.fetch(
        path: url.toString(), method: TFHTTPMethod.put, data: user.toJson());
    result = FSUser.fromJson(response.getResponse().data);
    return result;
  }

  /// delete user
  deteleUser(FSUser user) async {
    FSUser? result;
    Uri url = API.shared.getUserAPI(_APIUsers.deleteUser, {"userId": user.id});
    TFNetworkResponseModel response = await TFHTTPClient.shared
        .fetch(path: url.toString(), method: TFHTTPMethod.delete);
    result = FSUser.fromJson(response.getResponse().data);
    return result;
  }
}
