import 'package:legy/features/history/model/history_client_model.dart';
import 'package:legy/features/history/model/history_delivery_info_model.dart';
import 'package:legy/features/history/model/item_model.dart';
import 'package:legy/features/history/model/history_restaurant_model.dart';

class OrderModel {
  final String orderId;
  final List<ItemModel> items;
  final double total;
  final ClientModel client;
  final HistoryRestaurantModel restaurant;
  final DeliveryInfo? deliveryInfo; // updated type here
  final String deliveryAddress;
  final String livreurStatus;
  final String? deliveryMode;
  final String paymentStatus;
  final String paymentMethod;
  final String orderStatus;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.total,
    required this.client,
    required this.restaurant,
    this.deliveryInfo,
    required this.deliveryAddress,
    required this.livreurStatus,
    this.deliveryMode,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderStatus,
  });

  factory OrderModel.empty() {
    return OrderModel(
      orderId: '',
      items: [],
      total: 0.0,
      client: ClientModel.empty(),
      restaurant: HistoryRestaurantModel.empty(),
      deliveryInfo: null,
      deliveryAddress: '',
      livreurStatus: '',
      deliveryMode: null,
      paymentStatus: '',
      paymentMethod: '',
      orderStatus: '',
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => ItemModel.fromJson(item))
          .toList(),
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      client: json['client'] != null
          ? ClientModel.fromJson(json['client'])
          : ClientModel.empty(),
      restaurant: json['restaurant'] != null
          ? HistoryRestaurantModel.fromJson(json['restaurant'])
          : HistoryRestaurantModel.empty(),
      deliveryInfo: json['deliveryInfo'] != null
          ? DeliveryInfo.fromJson(json['deliveryInfo'])
          : null,
      deliveryAddress: json['deliveryAddress'] ?? '',
      livreurStatus: json['livreurStatus']?.toString() ?? '',
      deliveryMode: json['deliveryMode'] as String?,
      paymentStatus: json['paymentStatus']?.toString() ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
    );
  }

  OrderModel copyWith({
    String? orderId,
    List<ItemModel>? items,
    double? total,
    ClientModel? client,
    HistoryRestaurantModel? restaurant,
    DeliveryInfo? deliveryInfo,
    String? deliveryAddress,
    String? livreurStatus,
    String? deliveryMode,
    String? paymentStatus,
    String? paymentMethod,
    String? orderStatus,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      items: items ?? this.items,
      total: total ?? this.total,
      client: client ?? this.client,
      restaurant: restaurant ?? this.restaurant,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      livreurStatus: livreurStatus ?? this.livreurStatus,
      deliveryMode: deliveryMode ?? this.deliveryMode,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}
