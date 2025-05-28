import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/cart/presentation/app/order_state.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/cart/service/order_service.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderService orderService;

  OrderCubit({required this.orderService}) : super(const OrderState());

  Future<void> placeOrder({
    required List<ProductModel> products,
    required HomeProfileModel profile,
  }) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));

    try {
      print(profile.address);
      await orderService.createOrder(
        products: products,
        restaurantId: products.first.restaurantId,
        deliveryAddress: profile.address ?? 'the other value is null',
        paymentMethod: 'CASH',
      );

      emit(state.copyWith(isLoading: false, success: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
