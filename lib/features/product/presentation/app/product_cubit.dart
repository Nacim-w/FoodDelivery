import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/product/presentation/app/product_state.dart';
import 'package:legy/features/product/service/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productService}) : super(ProductInitial());

  final ProductService productService;

  Future<void> loadProductById(String id) async {
    emit(ProductLoading());
    try {
      final product = await productService.getProductById(id);
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
