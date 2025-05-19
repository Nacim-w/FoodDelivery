import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/burger/presentation/app/burger_details_provider.dart';
import 'package:provider/provider.dart';

class BurgerHeader extends StatefulWidget {
  const BurgerHeader({super.key});

  @override
  State<BurgerHeader> createState() => _BurgerHeaderState();
}

class _BurgerHeaderState extends State<BurgerHeader> {
  bool isFavorited = false;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String>> burgers = [
    {'image': Media.burger1},
    {'image': Media.burger2},
    {'image': Media.burger3},
    {'image': Media.burger4},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BurgerDetailsProvider>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              color: Colours.lightThemeBlack0,
              width: context.width,
              height: context.height,
              child: Column(
                children: [
                  context.adaptiveGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colours.lightThemeOrange0),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Le Coin des Burgers',
                        style: TextStyles.textMediumLarge.white1,
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorited
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colours.lightThemeOrange0,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                        },
                      ),
                    ],
                  ),
                  Gap(50),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: context.height * -0.3,
          right: context.width * -0.4,
          child: IgnorePointer(
            child: SvgPicture.asset(
              Media.bgLight,
              colorFilter: ColorFilter.mode(
                Colours.lightThemeYellow3.withAlpha(127),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        // Spinach 1 (Left)
        Positioned(
          top: context.height * 0.2,
          left: 0,
          child: Image(
            height: context.height * 0.25,
            width: context.width * 0.25,
            image: AssetImage(Media.spinach),
          ),
        ),
        // Spinach 2 (Right Top)
        Positioned(
          top: context.height * 0.1,
          right: 0,
          child: Image(
            height: context.height * 0.25,
            width: context.width * 0.25,
            image: AssetImage(Media.spinach2),
          ),
        ),
        // Pepper (Right Bottom)
        Positioned(
          top: context.height * 0.35,
          right: 0,
          child: Image(
            height: context.height * 0.3,
            width: context.width * 0.3,
            image: AssetImage(Media.pepper),
          ),
        ),
        // Burger carousel
        Positioned(
          top: context.height * 0.2,
          child: SizedBox(
            width: context.width,
            height: context.width * 0.6,
            child: PageView.builder(
              controller: provider.pageController,
              itemCount: burgers.length,
              onPageChanged: (index) {
                provider.setSelectedBurgerIndex(index);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: context.width * 0.8,
                    height: context.width * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(burgers[index]['image']!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
