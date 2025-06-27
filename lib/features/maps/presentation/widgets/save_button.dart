import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onPressed, required this.text});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.lightThemeOrange5,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
