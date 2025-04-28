import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CategoryHero extends StatefulWidget {
  const CategoryHero({super.key});

  @override
  State<CategoryHero> createState() => _CategoryHeroState();
}

class _CategoryHeroState extends State<CategoryHero> {
  int selectedIndex = 0;
  var rotationColor = Colours.lightThemeRed5;

  final List<String> categoryImages = [
    Media.categorie1,
    Media.categorie2,
    Media.categorie3,
  ];

  final List<String> swapImages = [
    Media.categorySwap1, // <-- Add your swap images here
    Media.categorySwap2,
    Media.categorySwap3,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cuisine Sénégalaise',
              style: TextStyles.text900fs28.red5,
            ),
            Gap(15),
            SizedBox(
              width: context.width * 0.58,
              child: AutoSizeText(
                'Dégustez l’authenticité des saveurs sénégalaises !',
                style: TextStyles.textMediumLarge.black1,
                maxLines: 2,
              ),
            ),
            Gap(50),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  backgroundColor: Colours.lightThemeWhite5,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: Colours.lightThemeRed5,
                    ),
                  ),
                ),
                child: Text(
                  "Goûtez Sénégal",
                  style: TextStyles.textSemiBoldSmall.red5,
                ),
              ),
            ),
            Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(categoryImages.length, (index) {
                return Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        splashColor: Colours.lightThemeGrey1.withAlpha(25),
                        customBorder: const CircleBorder(),
                        child: Image.asset(
                          categoryImages[index],
                          width: context.width * 0.18,
                          height: context.height * 0.1,
                        ),
                      ),
                    ),
                    Container(
                      width: context.width * 0.12,
                      height: 10,
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? rotationColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: context.height * 0.1,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween(begin: 0.7, end: 1.0).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Container(
              width: context.width * 0.4,
              height: context.width * 0.4,
              key: ValueKey<int>(selectedIndex),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                //color: Colors.red,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(swapImages[selectedIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
