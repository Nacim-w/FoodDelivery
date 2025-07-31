import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';

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
    return Scaffold(
      body: Column(
        children: [
          context.adaptiveGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlackAppBar(title: 'Carte', onTap: () => context.pop()),
          ),
          Gap(10),
          Expanded(child: BuiltMap()), // <-- Important
        ],
      ),
    );
  }
}
