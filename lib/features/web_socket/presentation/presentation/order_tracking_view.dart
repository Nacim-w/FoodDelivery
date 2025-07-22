import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/features/web_socket/service/web_socket_service.dart';

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

  late WebSocketService _webSocketService;

  @override
  void initState() {
    super.initState();
    _webSocketService = WebSocketService();

    _webSocketService.connectToLivreurLocation(widget.orderId, (lat, lon) {
      debugPrint('📍 WebSocket location update received: $lat, $lon');
      _animateMarker(LatLng(lat, lon));
    });
  }

  void _animateMarker(LatLng newPosition) {
    _animationTimer?.cancel(); // cancel any existing animation
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

      final double lat = _lerp(start.latitude, newPosition.latitude, currentStep / steps);
      final double lon = _lerp(start.longitude, newPosition.longitude, currentStep / steps);
      final LatLng intermediatePosition = LatLng(lat, lon);

      _setMarkerPosition(intermediatePosition);

      currentStep++;
    });
  }

  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  void _setMarkerPosition(LatLng position) {
    setState(() {
      _livreurMarker = Marker(
        markerId: const MarkerId('livreur_marker'),
        position: position,
        infoWindow: const InfoWindow(title: 'Livreur'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    });

    _mapController?.animateCamera(CameraUpdate.newLatLng(position)).then(
          (_) => debugPrint('📹 Camera moved to $position'),
          onError: (e) => debugPrint('❌ Camera movement error: $e'),
        );
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _webSocketService.disconnect();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi de la commande'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        markers: _livreurMarker != null ? {_livreurMarker!} : {},
        onMapCreated: (controller) {
          _mapController = controller;
          debugPrint('🗺 Google Map created');
        },
        myLocationEnabled: true,
      ),
    );
  }
}
