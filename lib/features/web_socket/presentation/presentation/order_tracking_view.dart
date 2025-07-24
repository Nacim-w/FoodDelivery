import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/web_socket/presentation/presentation/socket_manager.dart';
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
  LatLng _initialPosition = const LatLng(36.80611, 10.16579);
  LatLng? _previousPosition;
  Timer? _animationTimer;

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
      if (pos != null) _animateMarker(pos);
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
      _setMarkerPosition(LatLng(lat, lon));
      currentStep++;
    });
  }

  double _lerp(double start, double end, double t) => start + (end - start) * t;

  void _setMarkerPosition(LatLng position) {
    if (!mounted) return;
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

  void _stopTracking() {
    // Do NOT dispose socketManager here — keep it alive
    if (!mounted) return;
    setState(() {
      _livreurMarker = null;
      _previousPosition = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tracking stopped")),
    );
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
        return Center(child: Lottie.asset(Media.cooking));
      case OrderStatus.accepted:
        return Center(child: Lottie.asset(Media.delivery));
      case OrderStatus.onTheWay:
        final pos = socketManager.livreurLocation.value ?? _initialPosition;
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: pos, zoom: 14),
              markers: _livreurMarker != null ? {_livreurMarker!} : {},
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
            ),
            Positioned(
              top: 16,
              right: 16,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                icon: const Icon(Icons.stop_circle),
                label: const Text("Stop Tracking"),
                onPressed: _stopTracking,
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
    // Do NOT dispose socketManager here to keep state persistent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suivi de la commande')),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
