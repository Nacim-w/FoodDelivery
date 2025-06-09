import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:lottie/lottie.dart';

enum DeliveryStage { cooking, pickup, delivery }

class OrderTrackingMapView extends StatefulWidget {
  static const routePath = 'orderTracking';

  const OrderTrackingMapView({super.key});

  @override
  State<OrderTrackingMapView> createState() => _OrderTrackingMapViewState();
}

class _OrderTrackingMapViewState extends State<OrderTrackingMapView>
    with SingleTickerProviderStateMixin {
  final gmaps.LatLng userLocation = gmaps.LatLng(14.6928, -17.4467); // Dakar
  gmaps.LatLng restaurantLocation = gmaps.LatLng(14.7000, -17.4500);

  Timer? _movementTimer;
  DeliveryStage currentStage = DeliveryStage.cooking;

  double stageProgress = 0.0; // From 0 to 1 for progress line

  @override
  void initState() {
    super.initState();
    _startStageFlow();
  }

  void _startStageFlow() async {
    // Stage 1 → Stage 2
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          stageProgress = i / 100;
        });
      });
    }
    setState(() => currentStage = DeliveryStage.pickup);

    // Stage 2 → Stage 3
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          stageProgress = 1 + (i / 100);
        });
      });
    }
    setState(() => currentStage = DeliveryStage.delivery);
    _startMovingRestaurant();
  }

  @override
  void dispose() {
    _movementTimer?.cancel();
    super.dispose();
  }

  void _startMovingRestaurant() {
    const steps = 200;
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
    const earthRadius = 6371;

    final dLat = _degreesToRadians(end.latitude - start.latitude);
    final dLng = _degreesToRadians(end.longitude - start.longitude);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _showArrivalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colours.lightThemeWhite1,
        title: Text(
          'Livraison arrivée !',
          style: TextStyles.titleMediumSmall.black1,
        ),
        content: Text(
          'Votre commande est arrivée à destination. Bon appétit !',
          style: TextStyles.textMedium.black1,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                {Navigator.of(context).pop(), context.go(HomePage.routePath)},
            child: Text('Confirmer', style: TextStyles.textMedium.black1),
          )
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final icons = [
      Icons.restaurant, // Cooking
      Icons.delivery_dining, // Pickup
      Icons.check_circle, // Delivered
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(icons.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Between icons → progress line
          int stageIndex = (index - 1) ~/ 2;
          double fillAmount = 0;

          if (stageIndex == 0) {
            fillAmount = stageProgress.clamp(0, 1);
          } else if (stageIndex == 1) {
            fillAmount = (stageProgress - 1).clamp(0, 1);
          }

          return Container(
            width: 50,
            height: 4,
            child: LinearProgressIndicator(
              value: fillAmount,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        } else {
          // Icon itself
          int iconIndex = index ~/ 2;
          bool isActive = iconIndex <= currentStage.index;
          return CircleAvatar(
            radius: 20,
            backgroundColor: isActive ? Colors.orange : Colors.grey[300],
            child: Icon(
              icons[iconIndex],
              color: isActive ? Colors.white : Colors.grey,
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final distance = calculateDistance(userLocation, restaurantLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text('Suivi de Commande',
            style: TextStyles.titleMediumSmallest.black1),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildProgressIndicator(),
          ),
          Expanded(
            child: Stack(
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
                if (currentStage == DeliveryStage.cooking ||
                    currentStage == DeliveryStage.pickup)
                  Container(
                    color: Colors.white.withAlpha(200),
                    child: Center(
                      child: Lottie.asset(
                        currentStage == DeliveryStage.cooking
                            ? Media.cooking
                            : Media.delivery,
                      ),
                    ),
                  ),
                if (currentStage == DeliveryStage.delivery)
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
