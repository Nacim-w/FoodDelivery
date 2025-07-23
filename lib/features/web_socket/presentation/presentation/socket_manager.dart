import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/features/web_socket/presentation/presentation/order_tracking_view.dart';
import 'package:legy/features/web_socket/service/web_socket_service.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();

  factory SocketManager() => _instance;
  SocketManager._internal();

  final WebSocketService _locationService = WebSocketService();
  final WebSocketService _statusService = WebSocketService();

  final ValueNotifier<OrderStatus> orderStatus =
      ValueNotifier(OrderStatus.idle);
  final ValueNotifier<LatLng?> livreurLocation = ValueNotifier(null);

  bool _isInitialized = false;

  Future<void> initialize(String orderId, String clientId) async {
    if (_isInitialized) return;
    _isInitialized = true;

    _locationService.connectToLivreurLocation(orderId, (lat, lon) {
      livreurLocation.value = LatLng(lat, lon);
    });

    _statusService.connectToClientNotifications(clientId, (rawMessage) {
      try {
        final data = jsonDecode(rawMessage);
        final message = data['message']?.toString().toLowerCase() ?? '';

        if (message.contains('accepted')) {
          orderStatus.value = OrderStatus.accepted;
        } else if (message.contains('picked up') ||
            message.contains('driver is coming')) {
          orderStatus.value = OrderStatus.onTheWay;
        } else {
          orderStatus.value = OrderStatus.idle;
        }
      } catch (_) {}
    });
  }

  /// Call this ONLY when you want to permanently stop the connection.
  void disconnect() {
    _locationService.disconnect();
    _statusService.disconnect();
    _isInitialized = false;
  }
}
