import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';

class CurrentLocationButton extends StatefulWidget {
  const CurrentLocationButton({super.key});

  @override
  State<CurrentLocationButton> createState() => _CurrentLocationButtonState();
}

class _CurrentLocationButtonState extends State<CurrentLocationButton> {
  String _location = 'Get my location';
  bool _loading = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _loading = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          setState(() {
            _location = 'Permission Denied';
            _loading = false;
          });
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.high);
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      final Placemark place = placemarks.first;
      setState(() {
        _location = '${place.locality}, ${place.country}';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _location = 'Location error';
        _loading = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: Colours.lightThemeWhite1, // or your desired color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: _getCurrentLocation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Media.homePin,
            colorFilter: ColorFilter.mode(
              Colours.lightThemeOrange5,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          _loading
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colours.lightThemeOrange5,
                  ),
                )
              : Text(
                  _location,
                  style: const TextStyle(
                    color: Colours.lightThemeBlack0,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
        ],
      ),
    );
  }
}
