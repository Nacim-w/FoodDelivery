import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/features/product/presentation/app/product_state.dart';
import 'package:legy/features/product/service/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productService}) : super(ProductInitial());

  final ProductService productService;

  Future<void> loadProductById(String id) async {
    emit(ProductLoading());
    try {
      final product = await productService.getProductById(id);
      // Ensure quantity is initialized
      product.quantity = product.quantity; // Default to 1 if not initialized
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  // Method to update the quantity of supplements
  void updateSupplementQuantity(String supplementId, int quantity) {
    if (state is ProductLoaded) {
      final product = (state as ProductLoaded).product;

      // Update the supplement list
      final updatedSupplements = product.supplements.map((supplement) {
        if (supplement.id == supplementId) {
          supplement.quantity = quantity; // Update quantity
        }
        return supplement;
      }).toList();

      // Emit the new state with the updated list of supplements
      emit(ProductLoaded(
        ProductModel(
          id: product.id,
          restaurantId: product.restaurantId,
          name: product.name,
          description: product.description,
          categoryId: product.categoryId,
          supplements: updatedSupplements, // New list of supplements
          ingredients: product.ingredients,
          imageUrl: product.imageUrl,
          pricePostCom: product.pricePostCom,
          quantity:
              product.quantity, // Ensure product quantity is passed as well
        ),
      ));
    }
  }

  // Method to update product quantity
  void updateProductQuantity(String productId, int quantity) {
    if (state is ProductLoaded) {
      final product = (state as ProductLoaded).product;

      if (product.id == productId) {
        // Only emit the new state if the quantity actually changes
        if (product.quantity != quantity) {
          product.quantity = quantity; // Update quantity
          emit(ProductLoaded(product)); // Emit the updated product
        }
      }
    }
  }
}
