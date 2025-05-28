import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';

class ProductCover extends StatefulWidget {
  const ProductCover({super.key, required this.image});
  final String image;

  @override
  State<ProductCover> createState() => _ProductCoverState();
}

class _ProductCoverState extends State<ProductCover> {
  late Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  @override
  void didUpdateWidget(covariant ProductCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      _decodeImage();
    }
  }

  void _decodeImage() {
    final base64Str = widget.image.split(',').last;
    imageBytes = base64Decode(base64Str);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(imageBytes), // Use pre-decoded imageBytes
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}