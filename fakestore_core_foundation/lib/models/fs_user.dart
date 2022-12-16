import 'package:tf_framework/models/base_model.dart';
import 'package:tf_framework/utils/tf_logger.dart';

class FSUser extends TFModel {
  late final int id;
  late final String email;
  late final String username;
  FSUserName? fullName;
  late final String phone;
  late final String password;
  FSUserAddress? address;

  FSUser.fromJson(JSONData? json) {
    id = json?["id"] ?? 0;
    email = json?["email"] ?? "";
    username = json?["username"] ?? "";
    if (json?["name"] != null) {
      fullName = FSUserName.fromJson(json?["name"]);
    }
    phone = json?["phone"] ?? "";
    if (json?["address"] != null) {
      address = FSUserAddress.fromJson(json?["address"]);
    }
    password = json?["password"] ?? "";
  }

  static List<FSUser> parseFromList(List<dynamic>? listJson) {
    if (listJson == null) {
      return [];
    }
    List<FSUser> list = [];
    FSUser? temp;
    for (var element in listJson) {
      temp = null;
      temp = FSUser.fromJson(element);
      list.add(temp);
    }
    return list;
  }

  @override
  JSONData? toJson() {
    return {
      "id": id,
      "email": email,
      "username": username,
      "phone": phone,
      "password": password,
      "name": fullName?.toJson(),
      "address": address?.toJson()
    };
  }
}

class FSUserName extends TFModel {
  late final String firstName;
  late final String lastName;

  FSUserName.fromJson(JSONData? json) {
    firstName = json?["firstname"] ?? "";
    lastName = json?["lastname"] ?? "";
  }

  @override
  JSONData? toJson() {
    return {"firstname": firstName, "lastname": lastName};
  }
}

class FSUserAddress extends TFModel {
  late final String city;
  late final String street;
  late final int number;
  late final String zipcode;
  FSGeoLocation? geoLocation;

  FSUserAddress.fromJson(JSONData? json) {
    city = json?["city"] ?? "";
    street = json?["street"] ?? "";
    number = json?["number"] ?? 0;
    zipcode = json?["zipcode"] ?? "";
    if (json?["geolocation"] != null) {
      geoLocation = FSGeoLocation.fromJson(json?["geolocation"]);
    }
  }

  @override
  JSONData? toJson() {
    return {
      "geolocation": geoLocation?.toJson(),
      "city": city,
      "street": street,
      "number": number,
      "zipcode": zipcode
    };
  }
}

class FSGeoLocation extends TFModel {
  late final String latitude;
  late final String longitude;

  FSGeoLocation.fromJson(JSONData? json) {
    latitude = json?["lat"] ?? "";
    longitude = json?["long"] ?? "";
  }

  @override
  JSONData? toJson() {
    return {"lat": latitude, "long": longitude};
  }
}
