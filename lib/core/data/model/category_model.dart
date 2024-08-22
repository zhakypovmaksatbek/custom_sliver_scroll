// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:custom_sliver/core/data/model/product_model.dart';
import 'package:custom_sliver/core/data/model/sets_model.dart';
import 'package:flutter/material.dart';

final class CustomCategoryModel {
  CategoryModel? categoryModel;
  GlobalKey? globalKey;
  CustomCategoryModel({this.categoryModel, this.globalKey});
}

final class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? slug;
  String? image;
  List<ProductModel>? products;
  List<Sets>? sets;

  CategoryModel(
      {this.id,
      this.name,
      this.description,
      this.slug,
      this.image,
      this.products,
      this.sets});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    image = json['image'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
    if (json['sets'] != null) {
      sets = <Sets>[];
      json['sets'].forEach((v) {
        sets!.add(Sets.fromJson(v));
      });
    }
  }
  CategoryModel.fromJsonOnlyProducts(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['slug'] = slug;
    data['image'] = image;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (sets != null) {
      data['sets'] = sets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  String? name;
  String? photo;
  bool? possiblyRemove;

  Ingredients({this.name, this.photo, this.possiblyRemove});

  Ingredients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    possiblyRemove = json['possibly_remove'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['photo'] = photo;
    data['possibly_remove'] = possiblyRemove;
    return data;
  }
}

class Toppings {
  int? id;
  bool? possiblyRemove;
  String? name;
  int? price;
  String? photo;

  Toppings(
      {this.name,
      this.price,
      this.photo,
      this.id,
      this.possiblyRemove = false});

  Toppings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price']?.toInt();
    photo = json['photo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['photo'] = photo;
    data['id'] = id;
    return data;
  }

  @override
  String toString() {
    return 'Toppings(id: $id, possiblyRemove: $possiblyRemove, name: $name, price: $price, photo: $photo)';
  }
}

class ProductSizes {
  int? id;
  int? quantity;
  String? size;
  int? price;
  int? discountedPrice;
  int? bonusPrice;

  ProductSizes(
      {this.id,
      this.quantity,
      this.size,
      this.price,
      this.discountedPrice,
      this.bonusPrice});

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    price = json['price']?.toInt();
    discountedPrice = json['discounted_price']?.toInt();
    bonusPrice = json['bonus_price']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['size'] = size;
    data['price'] = price;
    data['discounted_price'] = discountedPrice;
    data['bonus_price'] = bonusPrice;
    return data;
  }
}
