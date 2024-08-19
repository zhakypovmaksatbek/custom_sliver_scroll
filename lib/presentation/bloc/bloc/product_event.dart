part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProduct extends ProductEvent {}
