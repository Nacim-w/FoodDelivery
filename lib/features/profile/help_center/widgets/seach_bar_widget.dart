import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: context.width * 0.9,
      child: TextField(
        style: const TextStyle(fontSize: 14), // Smaller font size
        decoration: InputDecoration(
          isDense: true, // Reduces vertical padding
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          hintText: 'Recherche',
          prefixIcon: const Icon(Icons.search, size: 20), // Smaller icon
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide:
                const BorderSide(color: Colours.lightThemeOrange5, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colours.lightThemeGrey2),
          ),
        ),
      ),
    );
  }
}
