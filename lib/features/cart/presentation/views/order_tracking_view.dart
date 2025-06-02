import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:legy/core/res/media.dart';
import 'package:lottie/lottie.dart';

class OrderTrackingMapView extends StatefulWidget {
  static const routePath = 'orderTracking';

  const OrderTrackingMapView({super.key});

  @override
  State<OrderTrackingMapView> createState() => _OrderTrackingMapViewState();
}

class _OrderTrackingMapViewState extends State<OrderTrackingMapView> {
  final gmaps.LatLng userLocation = gmaps.LatLng(14.6928, -17.4467); // Dakar
  gmaps.LatLng restaurantLocation =
      gmaps.LatLng(14.7000, -17.4500); // Start point

  Timer? _movementTimer;
  bool showAnimation = true; // <-- FLAG TO CONTROL ANIMATION

  @override
  void initState() {
    super.initState();

    // Show animation for 30 seconds, then show map
    Timer(Duration(seconds: 30), () {
      setState(() {
        showAnimation = false;
      });
      _startMovingRestaurant();
    });
  }

  @override
  void dispose() {
    _movementTimer?.cancel();
    super.dispose();
  }

  void _startMovingRestaurant() {
    const steps = 200; // More steps for slower movement
    int currentStep = 0;

    _movementTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        _showArrivalDialog();
        return;
      }

      final newLat = _lerp(restaurantLocation.latitude, userLocation.latitude,
          currentStep / steps);
      final newLng = _lerp(restaurantLocation.longitude, userLocation.longitude,
          currentStep / steps);

      setState(() {
        restaurantLocation = gmaps.LatLng(newLat, newLng);
      });

      // Check distance
      final distance = calculateDistance(userLocation, restaurantLocation);
      if (distance < 0.01) {
        timer.cancel();
        _showArrivalDialog();
      }

      currentStep++;
    });
  }

  double _lerp(double start, double end, double t) {
    return start + (end - start) * t;
  }

  double calculateDistance(gmaps.LatLng start, gmaps.LatLng end) {
    const earthRadius = 6371; // in km

    final dLat = _degreesToRadians(end.latitude - start.latitude);
    final dLng = _degreesToRadians(end.longitude - start.longitude);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = earthRadius * c;

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _showArrivalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Livraison arrivée !'),
        content:
            Text('Votre commande est arrivée à destination. Bon appétit ! 🍽️'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showAnimation) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(Media.cooking), // <-- PUT YOUR PATH HERE
        ),
      );
    }

    final distance = calculateDistance(userLocation, restaurantLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text('Suivi de Commande'),
      ),
      body: Stack(
        children: [
          gmaps.GoogleMap(
            initialCameraPosition: gmaps.CameraPosition(
              target: userLocation,
              zoom: 14,
            ),
            markers: {
              gmaps.Marker(
                markerId: gmaps.MarkerId('user'),
                position: userLocation,
                infoWindow: gmaps.InfoWindow(title: 'Vous'),
              ),
              gmaps.Marker(
                markerId: gmaps.MarkerId('restaurant'),
                position: restaurantLocation,
                infoWindow: gmaps.InfoWindow(title: 'Restaurant'),
              ),
            },
            polylines: {
              gmaps.Polyline(
                polylineId: gmaps.PolylineId('route'),
                points: [userLocation, restaurantLocation],
                color: Colors.blue,
                width: 4,
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Distance: ${distance.toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
