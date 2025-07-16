import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';

class RestaurantCover extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantCover({super.key, required this.restaurant});

  @override
  State<RestaurantCover> createState() => _RestaurantCoverState();
}

class _RestaurantCoverState extends State<RestaurantCover> {
  late ImageProvider imageProvider;

  @override
  void initState() {
    super.initState();
    _chooseImageProvider();
  }

  @override
  void didUpdateWidget(covariant RestaurantCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.restaurant.id != oldWidget.restaurant.id) {
      _chooseImageProvider();
    }
  }

  void _chooseImageProvider() {
    final logo = widget.restaurant.logo;

    if (logo.isEmpty) {
      imageProvider = const AssetImage(Media.restaurant1);
    } else if (logo.startsWith('http')) {
      imageProvider = NetworkImage(logo);
    } else if (logo.startsWith('data:image')) {
      try {
        final base64Str = logo.split(',').last;
        final imageBytes = base64Decode(base64Str);
        imageProvider = MemoryImage(imageBytes);
      } catch (_) {
        imageProvider = const AssetImage(Media.restaurant1);
      }
    } else {
      imageProvider = const AssetImage(Media.restaurant1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: imageProvider,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          Media.restaurant1,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
        );
      },
    );
  }
}
