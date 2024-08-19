part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<CategoryModel> products;
  ProductLoaded(this.products);
}

final class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
