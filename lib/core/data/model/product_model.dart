// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:custom_sliver/core/data/model/category_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? photo;
  List<Ingredients>? ingredients;
  List<Toppings>? toppings;
  List<ProductSizes>? productSizes;
  bool? bonuses;
  int? minPrice;
  int? bonusPrice;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.photo,
      this.ingredients,
      this.toppings,
      this.productSizes,
      this.bonuses,
      this.minPrice,
      this.bonusPrice});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
    if (json['toppings'] != null) {
      toppings = <Toppings>[];
      json['toppings'].forEach((v) {
        toppings!.add(Toppings.fromJson(v));
      });
    }
    if (json['product_sizes'] != null) {
      productSizes = <ProductSizes>[];
      json['product_sizes'].forEach((v) {
        productSizes!.add(ProductSizes.fromJson(v));
      });
    }
    bonuses = json['bonuses'];

    minPrice = json['min_price']?.toInt();

    bonusPrice = json['bonus_price']?.toInt();
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
    if (toppings != null) {
      data['toppings'] = toppings!.map((v) => v.toJson()).toList();
    }
    if (productSizes != null) {
      data['product_sizes'] = productSizes!.map((v) => v.toJson()).toList();
    }
    data['bonuses'] = bonuses;
    return data;
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, photo: $photo, ingredients: $ingredients, toppings: $toppings, productSizes: $productSizes, bonuses: $bonuses, minPrice: $minPrice)';
  }
}
