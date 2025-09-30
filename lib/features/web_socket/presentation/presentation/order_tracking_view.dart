import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';
import 'package:legy/features/web_socket/presentation/presentation/socket_manager.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  LatLng _initialPosition = const LatLng(36.80611, 10.16579);
  LatLng? _previousPosition;
  Timer? _animationTimer;

  final LatLng _destination = const LatLng(35.8233, 10.6360); // ISSAT Sousse
  Set<Polyline> _polylines = {};
  String? _estimatedTime; // ETA

  final socketManager = SocketManager();

  late VoidCallback _statusListener;
  late VoidCallback _locationListener;

  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  Future<void> _initSocket() async {
    final prefs = await SharedPreferences.getInstance();
    final profile = await CacheHelper(prefs).getCachedUserProfile();
    if (profile == null) return;

    await socketManager.initialize(widget.orderId, profile.id);

    _statusListener = () {
      if (!mounted) return;
      setState(() {});
    };

    _locationListener = () {
      final pos = socketManager.livreurLocation.value;
      if (pos != null) {
        _animateMarker(pos);
        _drawRoute(pos, _destination);
      }
    };

    socketManager.orderStatus.addListener(_statusListener);
    socketManager.livreurLocation.addListener(_locationListener);
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
      if (currentStep >= steps || !mounted) {
        timer.cancel();
        return;
      }

      final lat =
          _lerp(start.latitude, newPosition.latitude, currentStep / steps);
      final lon =
          _lerp(start.longitude, newPosition.longitude, currentStep / steps);
      final intermediatePosition = LatLng(lat, lon);
      _setMarkerPosition(intermediatePosition, animateCamera: true);
      currentStep++;
    });
  }

  double _lerp(double start, double end, double t) => start + (end - start) * t;

  void _setMarkerPosition(LatLng position, {bool animateCamera = false}) {
    if (!mounted) return;
    setState(() {
      _livreurMarker = Marker(
        markerId: const MarkerId('livreur_marker'),
        position: position,
        infoWindow: const InfoWindow(title: 'Livreur'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    });

    if (animateCamera) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(position),
      );
    }
  }

  /// Draw route along streets using Google Directions API + extract ETA
  Future<void> _drawRoute(LatLng origin, LatLng destination) async {
    const apiKey = 'AIzaSyCOxZCCAhsTSZPJwX7qumKmWaRKlTKpJew';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if ((data['routes'] as List).isNotEmpty) {
        final route = data['routes'][0];
        final points = route['overview_polyline']['points'];
        final decodedPoints = _decodePolyline(points);

        // ETA extraction
        final legs = route['legs'] as List;
        if (legs.isNotEmpty) {
          final duration = legs[0]['duration']['text']; // e.g. "15 mins"
          setState(() {
            _estimatedTime = duration;
          });
        }

        setState(() {
          _polylines = {
            Polyline(
              polylineId: const PolylineId('route_to_destination'),
              points: decodedPoints,
              color: Colors.blue,
              width: 5,
            )
          };
        });
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return poly;
  }

  Widget _buildProgressBar() {
    final activeColor = Colors.orange.shade400;
    final inactiveColor = Colors.grey.shade400;
    final status = socketManager.orderStatus.value;

    Color colorForStep(int index) {
      switch (status) {
        case OrderStatus.idle:
          return index == 0 ? activeColor : inactiveColor;
        case OrderStatus.accepted:
          return index <= 1 ? activeColor : inactiveColor;
        case OrderStatus.onTheWay:
          return activeColor;
      }
    }

    Widget stepIcon(int index, IconData icon) => CircleAvatar(
          radius: 16,
          backgroundColor: colorForStep(index),
          child: Icon(icon, color: Colors.white, size: 20),
        );

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          stepIcon(0, Icons.schedule),
          stepLine(0),
          stepIcon(1, Icons.restaurant_menu),
          stepLine(1),
          stepIcon(2, Icons.delivery_dining),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final status = socketManager.orderStatus.value;
    switch (status) {
      case OrderStatus.idle:
      case OrderStatus.accepted:
        final lottieAsset =
            status == OrderStatus.idle ? Media.cooking : Media.delivery;
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 14),
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
            ),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            Center(child: Lottie.asset(lottieAsset)),
          ],
        );
      case OrderStatus.onTheWay:
        final pos = socketManager.livreurLocation.value ?? _initialPosition;
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: pos, zoom: 14),
              markers: _livreurMarker != null ? {_livreurMarker!} : {},
              polylines: _polylines,
              onMapCreated: (controller) {
                _mapController = controller;
                if (_livreurMarker != null) {
                  _mapController!.moveCamera(
                      CameraUpdate.newLatLng(_livreurMarker!.position));
                }
              },
              myLocationEnabled: true,
            ),
            if (_estimatedTime != null)
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "⏱ $_estimatedTime",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
          ],
        );
    }
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _mapController?.dispose();
    socketManager.orderStatus.removeListener(_statusListener);
    socketManager.livreurLocation.removeListener(_locationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          context.adaptiveGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProfileSettingsAppbar(title: 'Suivi de la commande'),
          ),
          Gap(20),
          _buildProgressBar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
