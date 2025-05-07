import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';

class ProductCover extends StatelessWidget {
  const ProductCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Media.restaurant1,
      fit: BoxFit.cover,
      height: context.height * 0.3,
      width: double.infinity,
    );
  }
}
