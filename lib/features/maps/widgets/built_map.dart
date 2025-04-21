import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:legy/core/res/styles/colours.dart';

import 'package:legy/features/maps/map_widget.dart';
import 'package:legy/features/maps/widgets/save_button.dart';

class BuiltMap extends StatefulWidget {
  const BuiltMap({super.key});

  @override
  State<BuiltMap> createState() => _BuiltMapState();
}

class _BuiltMapState extends State<BuiltMap> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(14.6928, -17.4467);
  String? selectedCity;
  final Set<Marker> _markers = {}; // To hold the markers

  // Function to get the current location and move the map
  Future<void> _goToCurrentLocation() async {
    Position position = await _getCurrentLocation();
    final LatLng currentPosition =
        LatLng(position.latitude, position.longitude);

    // Animate the map to the new location
    mapController.animateCamera(
      CameraUpdate.newLatLng(currentPosition),
    );

    // Add a marker on the map
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: currentPosition,
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure), // Custom pin color
        ),
      );
    });
  }

  // Function to get the current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: GoogleMap(
                onMapCreated: (controller) => mapController = controller,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false, // Disable zoom controls
                markers: _markers, // Display the markers
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              right: 20,
              child: FloatingActionButton(
                onPressed: _goToCurrentLocation,
                backgroundColor: Colours.lightThemeOrange5,
                child: Icon(Icons.my_location, color: Colors.white),
              ),
            ),
          ],
        ),
        Gap(20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            child: Center(
              child: SaveButton(
                text: "Obtenir une direction",
                onPressed: () {
                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const MapBottomSheet();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
