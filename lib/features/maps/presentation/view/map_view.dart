import 'package:flutter/material.dart';

import 'package:legy/features/maps/presentation/widgets/built_map.dart';

class MapView extends StatefulWidget {
  static const routePath = 'map';
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return BuiltMap();
  }
}
