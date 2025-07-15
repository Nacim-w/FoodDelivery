import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';

class ProductCover extends StatefulWidget {
  const ProductCover({super.key, required this.image});
  final String image;

  @override
  State<ProductCover> createState() => _ProductCoverState();
}

class _ProductCoverState extends State<ProductCover> {
  late ImageProvider imageProvider;

  @override
  void initState() {
    super.initState();
    _resolveImage(widget.image);
  }

  @override
  void didUpdateWidget(covariant ProductCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      _resolveImage(widget.image);
    }
  }

  void _resolveImage(String image) {
    if (image.isEmpty) {
      imageProvider = const AssetImage(Media.restaurant1);
    } else if (image.startsWith('http')) {
      imageProvider = NetworkImage(image);
    } else if (image.startsWith('data:image')) {
      try {
        final base64Str = image.split(',').last;
        final bytes = base64Decode(base64Str);
        imageProvider = MemoryImage(bytes);
      } catch (_) {
        imageProvider = const AssetImage(Media.restaurant1);
      }
    } else {
      imageProvider = const AssetImage(Media.restaurant1);
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
