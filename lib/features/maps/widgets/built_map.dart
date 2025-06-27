import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/features/maps/model/saved_location_model.dart';

class BuiltMap extends StatefulWidget {
  const BuiltMap({super.key});

  @override
  State<BuiltMap> createState() => _BuiltMapState();
}

class _BuiltMapState extends State<BuiltMap> {
  late GoogleMapController mapController;
  LatLng? _initialPosition;
  final Set<Marker> _markers = {};

  final TextEditingController _customNameController = TextEditingController();
  final TextEditingController _readonlyZoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late CacheHelper cacheHelper;
  bool _isCacheReady = false;
  bool _isLocationReady = false;

  @override
  void initState() {
    super.initState();
    _initCacheAndLocation();
  }

  Future<void> _initCacheAndLocation() async {
    final prefs = await SharedPreferences.getInstance();
    cacheHelper = CacheHelper(prefs);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _useFallbackLocation();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _useFallbackLocation();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _initialPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      _isCacheReady = true;
      _isLocationReady = true;
    });
  }

  void _useFallbackLocation() {
    _initialPosition = const LatLng(14.6928, -17.4467);
    setState(() {
      _isCacheReady = true;
      _isLocationReady = true;
    });
  }

  @override
  void dispose() {
    _customNameController.dispose();
    _readonlyZoneController.dispose();
    super.dispose();
  }

  void _onMapTapped(LatLng tappedPoint) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      );
    });

    String formattedCoords =
        '(${tappedPoint.latitude.toStringAsFixed(4)}, ${tappedPoint.longitude.toStringAsFixed(4)})';
    _readonlyZoneController.text = formattedCoords;
    _customNameController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colours.lightThemeWhite1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Ajouter un emplacement',
              style: TextStyles.textBoldLarge.orange5),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _readonlyZoneController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Zone',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colours.lightThemeOrange0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colours.lightThemeOrange0, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _customNameController,
                  decoration: InputDecoration(
                    labelText: 'Nom personnalisé',
                    hintText: 'Ex: Maison, Bureau...',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colours.lightThemeOrange5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colours.lightThemeOrange5, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez entrer un nom personnalisé.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Annuler', style: TextStyles.textMediumLarge.grey1),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.lightThemeOrange5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final newLocation = SavedLocation(
                    latitude: tappedPoint.latitude,
                    longitude: tappedPoint.longitude,
                    name: _customNameController.text.trim(),
                  );

                  final currentLocations = cacheHelper.getSavedLocations();
                  currentLocations.add(newLocation);
                  await cacheHelper.cacheSavedLocations(currentLocations);

                  Navigator.of(dialogContext).pop();
                }
              },
              child:
                  Text('Soumettre', style: TextStyles.textMediumLarge.white1),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCacheReady || !_isLocationReady || _initialPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      onMapCreated: (controller) => mapController = controller,
      initialCameraPosition: CameraPosition(
        target: _initialPosition!,
        zoom: 15.0,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      markers: _markers,
      onTap: _onMapTapped,
    );
  }
}
