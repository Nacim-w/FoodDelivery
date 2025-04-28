import 'package:flutter/material.dart';

import 'package:legy/features/maps/widgets/built_map.dart';

class MapPage extends StatefulWidget {
  static const routePath = 'map';
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BuiltMap(),
        ],
      ),
    );
  }
}
