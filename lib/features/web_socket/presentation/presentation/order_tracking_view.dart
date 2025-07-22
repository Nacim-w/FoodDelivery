import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/web_socket/service/web_socket_service.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:shared_preferences/shared_preferences.dart';

enum OrderStatus { idle, accepted, onTheWay }

class OrderTrackingView extends StatefulWidget {
  static const routePath = 'order-trackingg';

  final String orderId;

  const OrderTrackingView({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderTrackingView> createState() => _OrderTrackingViewState();
}

class _OrderTrackingViewState extends State<OrderTrackingView> {
  GoogleMapController? _mapController;
  Marker? _livreurMarker;
  LatLng _initialPosition = const LatLng(36.80611, 10.16579); // Tunis default
  LatLng? _previousPosition;
  Timer? _animationTimer;

  late WebSocketService _wsLocationService;
  late WebSocketService _wsStatusService;

  OrderStatus _orderStatus = OrderStatus.idle;

  @override
  void initState() {
    super.initState();
    _wsLocationService = WebSocketService();
    _wsStatusService = WebSocketService();

    _wsLocationService.connectToLivreurLocation(widget.orderId, (lat, lon) {
      debugPrint('📍 WebSocket location update received: $lat, $lon');
      _animateMarker(LatLng(lat, lon));
    });

    _connectToStatusUpdates();
  }

  Future<void> _connectToStatusUpdates() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);
    final profile = await cacheHelper.getCachedUserProfile();

    if (profile != null && profile.id.isNotEmpty) {
      _wsStatusService.connectToClientNotifications(profile.id, (rawMessage) {
        debugPrint('📬 Received order status update: $rawMessage');

        try {
          final data = jsonDecode(rawMessage);
          final String message = data['message'] ?? '';

          setState(() {
            if (message.toLowerCase().contains('accepted')) {
              _orderStatus = OrderStatus.accepted;
            } else if (message.toLowerCase().contains('picked up') ||
                message.toLowerCase().contains('driver is coming')) {
              _orderStatus = OrderStatus.onTheWay;
            } else {
              _orderStatus = OrderStatus.idle;
            }
          });
        } catch (e) {
          debugPrint('❌ Failed to parse order status JSON: $e');
        }
      });
    }
  }

  void _animateMarker(LatLng newPosition) {
    _animationTimer?.cancel();
    final start = _previousPosition ?? newPosition;
    _previousPosition = newPosition;

    const steps = 30;
    const totalDuration = Duration(milliseconds: 600);
    final interval = totalDuration.inMilliseconds ~/ steps;
    int currentStep = 0;

    _animationTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        return;
      }

      final double lat =
          _lerp(start.latitude, newPosition.latitude, currentStep / steps);
      final double lon =
          _lerp(start.longitude, newPosition.longitude, currentStep / steps);
      final LatLng intermediatePosition = LatLng(lat, lon);

      _setMarkerPosition(intermediatePosition);

      currentStep++;
    });
  }

  double _lerp(double start, double end, double t) => start + (end - start) * t;

  void _setMarkerPosition(LatLng position) {
    setState(() {
      _livreurMarker = Marker(
        markerId: const MarkerId('livreur_marker'),
        position: position,
        infoWindow: const InfoWindow(title: 'Livreur'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    });

    _mapController?.animateCamera(CameraUpdate.newLatLng(position));
  }

  Widget _buildProgressBar() {
    // Active color and inactive color for steps
    final activeColor = Colors.orange.shade400;
    final inactiveColor = Colors.grey.shade400;

    Color colorForStep(int stepIndex) {
      switch (_orderStatus) {
        case OrderStatus.idle:
          return stepIndex == 0 ? activeColor : inactiveColor;
        case OrderStatus.accepted:
          return stepIndex <= 1 ? activeColor : inactiveColor;
        case OrderStatus.onTheWay:
          return activeColor;
      }
    }

    Widget stepIcon(int index, IconData iconData) {
      final isActive = colorForStep(index) == activeColor;
      return CircleAvatar(
        radius: 16,
        backgroundColor: isActive ? activeColor : inactiveColor,
        child: Icon(iconData, color: Colors.white, size: 20),
      );
    }

    Widget stepLine(int index) {
      final isActive = colorForStep(index) == activeColor &&
          colorForStep(index + 1) == activeColor;
      return Expanded(
        child: Container(
          height: 4,
          color: isActive ? activeColor : inactiveColor,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        children: [
          stepIcon(0, Icons.schedule), // waiting
          stepLine(0),
          stepIcon(1, Icons.restaurant_menu), // cooking
          stepLine(1),
          stepIcon(2, Icons.delivery_dining), // on the way
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_orderStatus) {
      case OrderStatus.idle:
        return Center(child: Lottie.asset(Media.delivery));
      case OrderStatus.accepted:
        return Center(child: Lottie.asset(Media.cooking));
      case OrderStatus.onTheWay:
        return GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _initialPosition, zoom: 14),
          markers: _livreurMarker != null ? {_livreurMarker!} : {},
          onMapCreated: (controller) {
            _mapController = controller;
            debugPrint('🗺 Google Map created');
          },
          myLocationEnabled: true,
        );
    }
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _wsLocationService.disconnect();
    _wsStatusService.disconnect();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi de la commande'),
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
