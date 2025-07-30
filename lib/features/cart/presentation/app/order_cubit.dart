import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/cart/presentation/app/order_state.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/cart/service/order_service.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderService orderService;

  OrderCubit({required this.orderService}) : super(const OrderState());

  Future<String> placeOrder({
    required List<ProductModel> products,
    required HomeProfileModel profile,
  }) async {
    // Validate location before order
    if (state.selectedLatitude == null || state.selectedLongitude == null) {
      // Emit error state with locationError = true
      emit(state.copyWith(locationError: true));

      // Reset locationError back to false so future errors retrigger listener
      Future.delayed(const Duration(milliseconds: 100), () {
        emit(state.copyWith(locationError: false));
      });

      throw Exception('Veuillez sélectionner un emplacement de livraison.');
    }

    // Reset locationError if valid
    emit(state.copyWith(
      isLoading: true,
      error: null,
      success: false,
      locationError: false,
    ));

    try {
      final orderId = await orderService.createOrder(
        products: products,
        restaurantId: products.first.restaurantId,
        deliveryAddress: profile.address,
        paymentMethod: 'CASH',
        latitude: state.selectedLatitude!,
        longitude: state.selectedLongitude!,
      );

      emit(state.copyWith(isLoading: false, success: true));
      return orderId;
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      rethrow;
    }
  }

  void updateLocation({
    required String name,
    required double latitude,
    required double longitude,
  }) {
    emit(state.copyWith(
      selectedLocationName: name,
      selectedLatitude: latitude,
      selectedLongitude: longitude,
    ));
  }
}
