import 'package:custom_sliver/core/data/model/category_model.dart';
import 'package:custom_sliver/core/settings/dio_settings.dart';
import 'package:dio/dio.dart';

class ProductRepo {
  final DioSettings dio = DioSettings();

  Future<List<CategoryModel>> getCategories() async {
    final Response response = await dio.get("products/categories/");
    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}
