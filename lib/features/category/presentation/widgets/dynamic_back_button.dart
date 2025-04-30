import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/category/presentation/app/provider/color_provider.dart';

class DynamicBackButton extends StatefulWidget {
  const DynamicBackButton({
    super.key,
  });

  @override
  State<DynamicBackButton> createState() => _DynamicBackButtonState();
}

class _DynamicBackButtonState extends State<DynamicBackButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: context.watch<ColorProvider>().color,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
