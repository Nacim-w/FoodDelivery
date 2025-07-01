import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/order_details/presentation/app/adapter/order_details_state.dart';
import 'package:legy/features/order_details/service/order_details_service.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderDetailsService orderDetailsService;

  OrderDetailsCubit({required this.orderDetailsService})
      : super(OrderDetailsInitial());

  Future<void> loadOrder(String orderId) async {
    emit(OrderDetailsLoading());
    try {
      final order = await orderDetailsService.fetchOrderDetails(orderId);
      emit(OrderDetailsLoaded(order));
    } catch (e) {
      emit(OrderDetailsError(e.toString()));
    }
  }
}
