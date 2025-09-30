// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/views/cart_view.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
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
  LatLng? _currentCenter;

  final TextEditingController _customNameController = TextEditingController();
  final TextEditingController _readonlyZoneController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late CacheHelper cacheHelper;
  bool _isCacheReady = false;
  bool _isLocationReady = false;
  bool _isMapMoving = false;

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
      desiredAccuracy: LocationAccuracy.high,
    );
    _initialPosition = LatLng(position.latitude, position.longitude);
    _currentCenter = _initialPosition;

    setState(() {
      _isCacheReady = true;
      _isLocationReady = true;
    });
  }

  void _useFallbackLocation() {
    _initialPosition = const LatLng(14.6928, -17.4467);
    _currentCenter = _initialPosition;
    setState(() {
      _isCacheReady = true;
      _isLocationReady = true;
    });
  }

  @override
  void dispose() {
    _customNameController.dispose();
    _readonlyZoneController.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _searchAndNavigate(String query) async {
    if (query.isEmpty) return;

    try {
      final locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final target = LatLng(location.latitude, location.longitude);
        mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Adresse introuvable")),
      );
    }
  }

  Future<void> _onConfirmLocation() async {
    final LatLng center = _currentCenter!;
    String readableAddress = 'Adresse inconnue';

    try {
      final placemarks =
          await placemarkFromCoordinates(center.latitude, center.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        readableAddress = [place.street, place.locality, place.country]
            .where((e) => e != null && e.isNotEmpty)
            .join(', ');
      }
    } catch (_) {}

    _readonlyZoneController.text = readableAddress;
    _customNameController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colours.lightThemeWhite1.withAlpha(200),
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
                    latitude: center.latitude,
                    longitude: center.longitude,
                    name: _customNameController.text.trim(),
                    description: _readonlyZoneController.text.trim(),
                  );

                  final currentLocations = cacheHelper.getSavedLocations();
                  currentLocations.add(newLocation);
                  await cacheHelper.cacheSavedLocations(currentLocations);

                  Navigator.of(dialogContext).pop();
                  context.push('${HomePage.routePath}/${CartView.routePath}');
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

    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          onMapCreated: (controller) => mapController = controller,
          initialCameraPosition: CameraPosition(
            target: _initialPosition!,
            zoom: 15.0,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          onCameraMove: (position) {
            _currentCenter = position.target;
            setState(() => _isMapMoving = true);
          },
          onCameraIdle: () => setState(() => _isMapMoving = false),
        ),

        // Search bar
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Material(
            color: Colours.lightThemeOrange5,
            borderRadius: BorderRadius.circular(99),
            elevation: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocus,
                onSubmitted: _searchAndNavigate,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colours.lightThemeWhite3,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  prefixIcon: SizedBox(
                    width: 48,
                    child: const Icon(
                      Icons.search,
                      color: Colours.lightThemeOrange0,
                    ),
                  ),
                  hintText: "Rechercher",
                  hintStyle: TextStyles.textMediumSmall.grey3,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyles.textMediumSmall,
              ),
            ),
          ),
        ),

        // Center marker
        IgnorePointer(
          child: AnimatedScale(
            scale: _isMapMoving ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.location_on,
                size: 40, color: Colours.lightThemeOrange5),
          ),
        ),

        // Confirmation button
        Positioned(
          bottom: 30,
          left: 20,
          right: 20,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colours.lightThemeOrange5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _onConfirmLocation,
            child: Text('Confirmer cet emplacement',
                style: TextStyles.textMediumLarge.white1),
          ),
        ),
      ],
    );
  }
}
