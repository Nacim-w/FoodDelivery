import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';

class RestaurantCover extends StatelessWidget {
  const RestaurantCover({super.key, required this.restaurant});
  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    final base64Str = restaurant.logo.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);
    return Image.memory(
      imageBytes,
      fit: BoxFit.cover,
      height: context.height * 0.4,
      width: double.infinity,
    );
  }
}
