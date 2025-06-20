import 'dart:convert';

import 'package:legy/features/web_socket/model/location.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class TrackingService {
  StompClient? _stompClient;
  Function(LocationUpdateModel)? onLocationReceived;

  void connect(String orderId) {
    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'https://api.dev.legy.bramasquare.com/ws',
        onConnect: (StompFrame frame) {
          _subscribeToLocation(orderId);
        },
        onWebSocketError: (error) => print('WebSocket Error: $error'),
        onStompError: (frame) => print('STOMP Error: ${frame.body}'),
        onDisconnect: (frame) => print('Disconnected'),
      ),
    );

    _stompClient?.activate();
  }

  void _subscribeToLocation(String orderId) {
    _stompClient?.subscribe(
      destination: '/topic/orders/685176b717566c1fd71d8595/location',
      callback: (frame) {
        final data = jsonDecode(frame.body!);
        final update = LocationUpdateModel.fromJson(data);
        if (onLocationReceived != null) {
          onLocationReceived!(update);
        }
      },
    );
  }

  void disconnect() {
    _stompClient?.deactivate();
    _stompClient = null;
  }
}
