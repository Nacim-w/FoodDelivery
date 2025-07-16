import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/features/web_socket/service/web_socket_service.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late WebSocketService _webSocketService;
  Timer? _pollingTimer;
  String? _livreurId;

  @override
  void initState() {
    super.initState();
    _webSocketService = WebSocketService();
    _startPollingForLivreurId();
  }

  Future<void> _startPollingForLivreurId() async {
    final cacheHelper = CacheHelper(await SharedPreferences.getInstance());
    final token = cacheHelper.getSessionToken();

    if (token == null) {
      debugPrint('⚠️ No auth token found.');
      return;
    }

    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final livreurId = await _fetchDeliveryPersonId(widget.orderId, token);
        if (livreurId != null && livreurId.isNotEmpty) {
          timer.cancel();
          debugPrint('✅ Livreur assigned: $livreurId');
          setState(() => _livreurId = livreurId);

          _webSocketService.connectToLivreurLocation(_livreurId!, (lat, lon) {
            debugPrint('📍 WebSocket location update received: $lat, $lon');
            _updateLivrerMarker(lat, lon);
          });
        } else {
          debugPrint('🔁 Still waiting for livreur assignment...');
        }
      } catch (e) {
        debugPrint('❌ Polling error: $e');
      }
    });
  }

  Future<String?> _fetchDeliveryPersonId(String orderId, String token) async {
    final url =
        Uri.parse('${NetworkConstants.baseUrl}/api/orders/$orderId/details');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final livreurId = data['deliveryInfo']?['deliveryPersonId'];
      debugPrint('📦 API responded with livreurId: $livreurId');
      if (livreurId is String && livreurId.isNotEmpty) {
        return livreurId;
      }
    } else {
      debugPrint(
          '❌ Failed to fetch order details: HTTP ${response.statusCode}');
    }
    return null;
  }

  void _updateLivrerMarker(double latitude, double longitude) {
    final position = LatLng(latitude, longitude);
    debugPrint('🗺 Updating marker position to: $position');

    setState(() {
      _livreurMarker = Marker(
        markerId: const MarkerId('livreur_marker'),
        position: position,
        infoWindow: const InfoWindow(title: 'Livreur'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    });

    if (_mapController != null) {
      _mapController!
          .animateCamera(CameraUpdate.newLatLng(position))
          .then((_) => debugPrint('📹 Camera moved to $position'))
          .catchError((e) => debugPrint('❌ Camera movement error: $e'));
    } else {
      debugPrint('⚠️ Map controller is null; can’t animate camera.');
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
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
