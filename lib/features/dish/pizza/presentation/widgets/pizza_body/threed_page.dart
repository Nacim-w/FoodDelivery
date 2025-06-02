import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class My3DViewer extends StatelessWidget {
  const My3DViewer({super.key, required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Let background go behind app bar
      appBar: AppBar(
        title: const Text(
          "3D Model Viewer",
          style: TextStyles.titleMediumSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colours.lightThemeYellow0.withAlpha(20),
              Colours.lightThemeOrange3,
              Colors.black
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ModelViewer(
            src: asset,
            alt: "A 3D model of a pizza",
            ar: true,
            autoRotate: true,
            cameraControls: true,
            backgroundColor:
                Colors.transparent, // Let the gradient show through
          ),
        ),
      ),
    );
  }
}
