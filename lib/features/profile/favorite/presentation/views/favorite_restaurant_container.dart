import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class FavoriteRestaurantContainer extends StatelessWidget {
  const FavoriteRestaurantContainer(
      {super.key,
      required this.image,
      required this.name,
      required this.rating});
  final String image;
  final String name;
  final double rating;

  @override
  Widget build(BuildContext context) {
    //final base64Str = image.split(',').last;
    //Uint8List imageBytes = base64Decode(base64Str);

    return Stack(
      children: [
        Container(
          width: context.width * 0.6,
          height: context.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ), /*DecorationImage(
              image: MemoryImage(imageBytes),
              fit: BoxFit.cover,
            ),*/
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(200), // 80% opacity at the top
                    Colors.black.withAlpha(0), // 0% opacity at the bottom
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          child: Container(
            width: context.width * 0.16,
            height: context.height * 0.028,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
              ),
              color: Colors.red,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.white, size: 12),
                Text('$rating', style: TextStyles.textBoldSmall.white1)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyles.textBoldSmall.white1,
              ),
              Text('Indian - Mangalore',
                  style: TextStyles.textRegularSmallest.white1),
              Row(
                children: [
                  Text('15 min ', style: TextStyles.textBoldSmallest.white1),
                  Icon(
                    Icons.circle,
                    size: 4,
                    color: Colours.lightThemeWhite1,
                  ),
                  Text(' 3 km', style: TextStyles.textBoldSmallest.white1)
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: context.width * 0.07,
            height: context.height * 0.07,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colours.lightThemeOrange0,
            ),
            child: Center(
              // Optional: to center the icon
              child: SvgPicture.asset(
                Media.favoriteOrangy,
                width: context.width * 0.035,
                height: context.height * 0.02,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
