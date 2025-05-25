import 'package:equatable/equatable.dart';
import 'package:legy/features/product/model/product_model.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final ProductModel? product;
  final String? error;
  final bool isFavorite;

  const ProductState({
    this.isLoading = false,
    this.product,
    this.error,
    this.isFavorite = false,
  });

  ProductState copyWith({
    bool? isLoading,
    ProductModel? product,
    String? error,
    bool? isFavorite,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      error: error,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [isLoading, product, error, isFavorite];
}
