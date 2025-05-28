import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart'; // Assuming this provides context.height
import 'package:legy/features/restaurant/model/restaurant_model.dart';

class RestaurantCover extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantCover({super.key, required this.restaurant});

  @override
  State<RestaurantCover> createState() => _RestaurantCoverState();
}

class _RestaurantCoverState extends State<RestaurantCover> {
  late Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  @override
  void didUpdateWidget(covariant RestaurantCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.restaurant.id != oldWidget.restaurant.id) {
      _decodeImage();
    }
  }

  void _decodeImage() {
    final base64Str = widget.restaurant.logo.split(',').last;
    imageBytes = base64Decode(base64Str);
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageBytes,
      fit: BoxFit.cover,
      height: context.height * 0.4,
      width: double.infinity,
    );
  }
}