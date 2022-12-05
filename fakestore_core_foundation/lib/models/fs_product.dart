import 'package:tf_framework/models/base_model.dart';

import 'fs_category.dart';

class FSProduct extends TFModel {
  late final int id;
  late final String title;
  late final double price;
  late final String description;
  late final String image;
  late final FSProductRating rating;
  late final FSProductCategory category;

  FSProduct.fromJson(JSONData json) {
    id = json["id"] ?? 0;
    title = json["title"] ?? "";
    price = json["price"] ?? 0;
    description = json["description"] ?? "";
    image = json["image"] ?? "";
    category = categoryEnumFromString(json["category"] ?? "");
    rating = FSProductRating.fromJson(json["rating"]);
  }

  @override
  JSONData? toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "image": image,
      "rating": rating.toJson(),
      "category": stringFromProductCategory(category)
    };
  }
}

class FSProductRating extends TFModel {
  late final double rate;
  late final int count;

  FSProductRating.fromJson(JSONData json) {
    rate = json["rate"] ?? 0;
    count = json["count"] ?? 0;
  }

  @override
  JSONData? toJson() {
    return {"rate": rate, "count": count};
  }
}
