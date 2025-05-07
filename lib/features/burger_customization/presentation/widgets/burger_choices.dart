import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';

class BurgerChoices extends StatefulWidget {
  const BurgerChoices({super.key});

  @override
  State<BurgerChoices> createState() => _BurgerChoicesState();
}

class _BurgerChoicesState extends State<BurgerChoices> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.3,
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal, // Makes it horizontally scrollable
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          Container(
            width: context.width * 0.3,
            height: context.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              Media.bun1,
            ),
          ),
          Container(
            width: context.width * 0.3,
            height: context.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              Media.bun4,
            ),
          ),
          Container(
            width: context.width * 0.3,
            height: context.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              Media.bun3,
            ),
          ),
          Container(
            width: context.width * 0.3,
            height: context.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              Media.bun2,
            ),
          ),
          Container(
            width: context.width * 0.3,
            height: context.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              Media.bun5,
            ),
          ),
        ],
      ),
    );
  }
}
