import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/product/presentation/app/product_state.dart';
import 'package:legy/features/product/service/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService productService;

  ProductCubit({required this.productService}) : super(const ProductState());

  Future<void> loadProductById(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final product = await productService.getProductById(id);
      product.quantity = product.quantity;
      emit(state.copyWith(isLoading: false, product: product));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void updateSupplementQuantity(String supplementId, int quantity) {
    final product = state.product;
    if (product != null) {
      final updatedSupplements = product.supplements.map((supplement) {
        if (supplement.id == supplementId) {
          supplement.quantity = quantity;
        }
        return supplement;
      }).toList();

      final updatedProduct = product.copyWith(supplements: updatedSupplements);
      emit(state.copyWith(product: updatedProduct));
    }
  }

  void updateProductQuantity(String productId, int quantity) {
    final product = state.product;
    if (product != null &&
        product.id == productId &&
        product.quantity != quantity) {
      final updatedProduct = product.copyWith(quantity: quantity);
      emit(state.copyWith(product: updatedProduct));
    }
  }

  Future<void> toggleFavoriteStatus(String productId) async {
    try {
      final isCurrentlyFavorite = state.isFavorite;

      if (isCurrentlyFavorite) {
        await productService.removeFavorite(productId: productId);
      } else {
        await productService.addFavorite(productId: productId);
      }

      emit(state.copyWith(isFavorite: !isCurrentlyFavorite));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update favorite status'));
    }
  }
}
