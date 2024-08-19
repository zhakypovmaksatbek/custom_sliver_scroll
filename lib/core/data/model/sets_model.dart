

import 'package:custom_sliver/core/data/model/category_model.dart';

class Sets {
  int? id;
  String? name;
  String? description;
  String? photo;
  List<SetProducts>? products;
  int? price;
  int? discountedPrice;
  bool? bonuses;

  Sets(
      {this.id,
      this.name,
      this.description,
      this.photo,
      this.products,
      this.price,
      this.discountedPrice,
      this.bonuses});

  Sets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    if (json['products'] != null) {
      products = <SetProducts>[];
      json['products'].forEach((v) {
        products!.add(SetProducts.fromJson(v));
      });
    }
    price = json['price']?.toInt();
    discountedPrice = json['discounted_price']?.toInt();
    bonuses = json['bonuses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['photo'] = photo;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    data['bonuses'] = bonuses;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? photo;
  List<Ingredients>? ingredients;

  Product({this.id, this.name, this.description, this.photo, this.ingredients});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['photo'] = photo;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SetProducts {
  Product? product;
  String? size;
  int? price;
  int? discountedPrice;

  SetProducts({this.product, this.size, this.price, this.discountedPrice});

  SetProducts.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    size = json['size'];
    price = json['price']?.toInt();
    discountedPrice = json['discounted_price']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['size'] = size;
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    return data;
  }
}
