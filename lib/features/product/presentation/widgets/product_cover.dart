import 'package:flutter/material.dart';
import 'package:legy/core/extension/decode_extension.dart';
import 'package:legy/core/extension/media_extension.dart';

class ProductCover extends StatelessWidget {
  const ProductCover({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(image.decodeImage()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
