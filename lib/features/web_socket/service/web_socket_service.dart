import 'dart:convert';
import 'package:legy/core/utils/network_constants.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  StompClient? _stompClient;

  // Connect for order status notifications
  void connectToClientNotifications(String clientId) {
    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '${NetworkConstants.baseUrl}/ws',
        onConnect: (StompFrame frame) {
          print('✅ WebSocket connected for order notifications');

          _stompClient!.subscribe(
            destination: '/topic/client/$clientId/order-status',
            callback: (StompFrame message) {
              if (message.body != null) {
                final body = message.body!;
                print('📬 Received order status update: $body');
              }
            },
          );
        },
        onWebSocketError: (dynamic error) => print('❌ WebSocket Error: $error'),
        onStompError: (frame) => print('❌ STOMP Error: ${frame.body}'),
        onDisconnect: (frame) =>
            print('🔌 Disconnected from order notifications'),
        heartbeatOutgoing: const Duration(seconds: 10),
        heartbeatIncoming: const Duration(seconds: 10),
        reconnectDelay: const Duration(seconds: 5),
      ),
    );

    _stompClient!.activate();
  }

  // Connect specifically for livreur location updates
  void connectToLivreurLocation(
    String livreurId,
    void Function(double lat, double lon) onLocationUpdate,
  ) {
    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '${NetworkConstants.baseUrl}/ws',
        onConnect: (StompFrame frame) {
          print('✅ WebSocket connected for livreur location tracking');

          _stompClient!.subscribe(
            destination: '/topic/livreurs/$livreurId/location',
            callback: (StompFrame message) {
              print('📬 Livreur location frame: ${message.body}');

              if (message.body != null) {
                try {
                  final data = jsonDecode(message.body!);
                  final latStr = data['latitude'] as String?;
                  final lonStr = data['longitude'] as String?;

                  if (latStr == null || lonStr == null) {
                    print('⚠️ Received null coordinates: $data');
                    return;
                  }

                  final latDouble = double.tryParse(latStr);
                  final lonDouble = double.tryParse(lonStr);

                  if (latDouble == null || lonDouble == null) {
                    print('⚠️ Failed to parse coordinates: $data');
                    return;
                  }

                  print('📍 Location parsed: $latDouble, $lonDouble');
                  onLocationUpdate(latDouble, lonDouble);
                } catch (e) {
                  print('❌ Error parsing location data: $e');
                }
              }
            },
          );
        },
        onWebSocketError: (dynamic error) => print('❌ WebSocket Error: $error'),
        onStompError: (frame) => print('❌ STOMP Error: ${frame.body}'),
        onDisconnect: (frame) =>
            print('🔌 Disconnected from livreur location tracking'),
        heartbeatOutgoing: const Duration(seconds: 10),
        heartbeatIncoming: const Duration(seconds: 10),
        reconnectDelay: const Duration(seconds: 5),
      ),
    );

    _stompClient!.activate();
  }

  // Disconnect current connection
  void disconnect() {
    _stompClient?.deactivate();
    print('🔌 WebSocket Disconnected');
  }
}
