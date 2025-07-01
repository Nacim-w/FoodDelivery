import 'package:legy/features/order_details/model/details_client_model.dart';
import 'package:legy/features/order_details/model/details_items_model.dart';
import 'package:legy/features/order_details/model/details_restaurant_model.dart';

class OrderDetailsModel {
  final String id;
  final List<DetailsOrderItem> items;
  final double total;
  final DetailsClientModel client;
  final DetailsRestaurantModel restaurant;
  final String deliveryAddress;
  final String orderStatus;
  final String livreurStatus;
  final String deliveryMode;
  final String paymentStatus;
  final String paymentMethod;

  OrderDetailsModel({
    required this.id,
    required this.items,
    required this.total,
    required this.client,
    required this.restaurant,
    required this.deliveryAddress,
    required this.orderStatus,
    required this.livreurStatus,
    required this.deliveryMode,
    required this.paymentStatus,
    required this.paymentMethod,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['orderId'], // Fix: was 'id'
      items: (json['items'] as List<dynamic>)
          .map((item) => DetailsOrderItem.fromJson(item))
          .toList(),
      total: (json['total'] as num).toDouble(),
      client: json['client'] != null
          ? DetailsClientModel.fromJson(json['client'])
          : DetailsClientModel.empty(), // Optional: fallback
      restaurant: json['restaurant'] != null
          ? DetailsRestaurantModel.fromJson(json['restaurant'])
          : DetailsRestaurantModel.empty(), // Optional: fallback
      deliveryAddress: json['deliveryAddress'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      livreurStatus: json['livreurStatus'] ?? '',
      deliveryMode: json['deliveryMode'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }
}
