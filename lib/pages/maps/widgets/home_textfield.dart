import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/colours.dart';

class HomeTextfield extends StatelessWidget {
  const HomeTextfield({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colours.lightThemeGrey2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Colours.lightThemeOrange5, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
