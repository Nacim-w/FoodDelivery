import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class CategoryDessertHero extends StatefulWidget {
  final ValueChanged<int>? onCategoryChanged;

  const CategoryDessertHero({super.key, this.onCategoryChanged});

  @override
  State<CategoryDessertHero> createState() => _CategoryDessertHeroState();
}

class _CategoryDessertHeroState extends State<CategoryDessertHero> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: context.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Délices Sucrés',
                  style: TextStyles.text900fs28.copyWith(
                    color: Colours.lightThemeBrown5,
                  ),
                ),
                Gap(15),
                SizedBox(
                  width: context.width * 0.5,
                  height: context.height * 0.1,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: AutoSizeText(
                      'Dégustez les douceurs sucrées de notre sélection !',
                      style: TextStyles.textMediumLarge.black1,
                      maxLines: 3,
                    ),
                  ),
                ),
                Gap(15),
                SizedBox(
                  width: context.width * 0.38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      backgroundColor: Colours.lightThemeWhite5,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: Colours.lightThemeBrown5,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Goûtez Sénégal',
                      style: TextStyles.textSemiBoldSmall.brown5,
                    ),
                  ),
                ),
                Gap(24),
              ],
            ),
            Positioned(
              right: 0,
              top: context.width * 0.1,
              child: Container(
                width: context.width * 0.42,
                height: context.width * 0.42,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(Media.dessertHero),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
