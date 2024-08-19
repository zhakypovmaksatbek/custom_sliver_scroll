import 'package:custom_sliver/core/data/model/category_model.dart';
import 'package:custom_sliver/core/data/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProduct) {
        emit(ProductLoading());
        try {
          final data = await _repo.getCategories();
          emit(ProductLoaded(data));
        } catch (e) {
          emit(ProductError(e.toString()));
        }
      }
    });
  }

  final ProductRepo _repo = ProductRepo();
}
