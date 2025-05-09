import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';

class RestaurantAppbar extends StatefulWidget {
  const RestaurantAppbar({super.key});

  @override
  State<RestaurantAppbar> createState() => _RestaurantAppbarState();
}

class _RestaurantAppbarState extends State<RestaurantAppbar> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colours.lightThemeWhite1,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: context.width * 0.1,
              height: context.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colours.lightThemeOrange5,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: context.width * 0.05,
                  color: Colours.lightThemeOrange5,
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colours.lightThemeWhite1,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Container(
              width: context.width * 0.1,
              height: context.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colours.lightThemeOrange5,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: context.width * 0.05,
                  color: Colours.lightThemeOrange5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
