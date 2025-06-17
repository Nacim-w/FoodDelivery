import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:legy/features/web_socket/presentation/app/adapter/tracking_cubit.dart';
import 'package:legy/features/web_socket/presentation/app/adapter/tracking_service.dart';

class TrackingView extends StatefulWidget {
  final String orderId;

  const TrackingView({super.key, required this.orderId});
  static const routePath = 'tracking-order';

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  // ignore: unused_field
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    context.read<TrackingCubit>().startTracking(widget.orderId);
  }

  @override
  void dispose() {
    context.read<TrackingCubit>().stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        final location = state.location;

        return Scaffold(
          appBar: AppBar(title: const Text('Tracking Livreur')),
          body: location == null
              ? const Center(child: Text('Waiting for location...'))
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 16,
                  ),
                  onMapCreated: (controller) => _mapController = controller,
                  markers: {
                    Marker(
                      markerId: const MarkerId('livreur'),
                      position: LatLng(location.latitude, location.longitude),
                      infoWindow: const InfoWindow(title: 'Livreur'),
                    ),
                  },
                ),
        );
      },
    );
  }
}
