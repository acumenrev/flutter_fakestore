import 'package:tf_framework/models/base_error.dart';
import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/network/tf_http_client.dart';

class APICall {
  JSONData generateNetworkResponse(dynamic? data, TFError? err) {
    JSONData result = {};
    result["data"] = data;
    result["error"] = err;
    return result;
  }
}
