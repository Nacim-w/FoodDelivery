import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';

class RecommandedContainer extends StatelessWidget {
  const RecommandedContainer({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.44,
      height: context.height * 0.17,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack3.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: Colours.lightThemeWhite1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
