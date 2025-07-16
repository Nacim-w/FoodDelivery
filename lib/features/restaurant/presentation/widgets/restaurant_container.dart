import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class RestaurantContainer extends StatelessWidget {
  const RestaurantContainer({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
  });

  final String image;
  final String name;
  final double rating;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (image.isEmpty) {
      imageWidget = Image.asset(
        Media.restaurant1,
        fit: BoxFit.cover,
      );
    } else if (image.startsWith('http')) {
      imageWidget = Image.network(
        image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(Media.restaurant1, fit: BoxFit.cover);
        },
      );
    } else if (image.startsWith('data:image')) {
      try {
        final base64Str = image.split(',').last;
        Uint8List imageBytes = base64Decode(base64Str);
        imageWidget = Image.memory(imageBytes, fit: BoxFit.cover);
      } catch (_) {
        imageWidget = Image.asset(Media.restaurant1, fit: BoxFit.cover);
      }
    } else {
      imageWidget = Image.asset(Media.restaurant1, fit: BoxFit.cover);
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: context.width * 0.45,
            height: context.height * 0.25,
            child: imageWidget,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(200),
                    Colors.black.withAlpha(0),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        // Rating box
        Positioned(
          top: 60,
          left: 0,
          child: Container(
            width: context.width * 0.16,
            height: context.height * 0.028,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
              color: Colors.red,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.white, size: 12),
                Text('$rating', style: TextStyles.textBoldSmall.white1),
              ],
            ),
          ),
        ),
        // Restaurant name and details
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyles.textBoldSmall.white1),
              Text('Indian - Mangalore',
                  style: TextStyles.textRegularSmallest.white1),
              Row(
                children: [
                  SvgPicture.asset(Media.clock, width: 12, height: 12),
                  Text('  15 min', style: TextStyles.textBoldSmallest.white1),
                  Text(' - ', style: TextStyles.textBoldSmallest.white1),
                  Text('3 km', style: TextStyles.textBoldSmallest.white1),
                ],
              ),
            ],
          ),
        ),
        // Camera icon
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: context.width * 0.07,
            height: context.height * 0.07,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colours.lightThemeYellow0,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
