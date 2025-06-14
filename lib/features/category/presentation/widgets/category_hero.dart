import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/category/presentation/app/category_cubit.dart';
import 'package:legy/features/category/presentation/app/provider/category_provider.dart';

class CategoryHero extends StatefulWidget {
  final ValueChanged<int>? onCategoryChanged;

  const CategoryHero({super.key, this.onCategoryChanged});

  @override
  State<CategoryHero> createState() => _CategoryHeroState();
}

class _CategoryHeroState extends State<CategoryHero> {
  int? selectedIndex;

  final List<String> categoryImages = [
    Media.categorie1,
    Media.categorie2,
    Media.categorie3,
  ];

  final List<String> swapImages = [
    Media.categorySwap1,
    Media.categorySwap2,
    Media.categorySwap3,
  ];

  final List<Color> categoryColors = [
    Colours.lightThemeRed5,
    Colours.lightThemeOrange5,
    Colours.lightThemeGreen5,
  ];

  final List<String> categoryTitles = [
    'Cuisine Sénégalaise',
    'Cuisine Internationale',
    'Cuisine Saine',
  ];

  final List<String> categorySubtitles = [
    'Dégustez l’authenticité des saveurs sénégalaises !',
    'Saveurs italiennes, asiatiques, libanaises et plus !',
    'Dégustez l’authenticité des saveurs sénégalaises !',
  ];

  final List<String> categoryButton = [
    'Goûtez Sénégal',
    'Explorez le Monde',
    'Goûtez Saine',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialIndex = context.read<CategoryProvider>().index;
      setState(() {
        selectedIndex = initialIndex;
      });
      context.read<CategoryProvider>().changeColor(
            newColor: categoryColors[initialIndex],
          );
    });
  }

  void onCategorySelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    context
        .read<CategoryProvider>()
        .changeColor(newColor: categoryColors[index]);
    context.read<CategoryProvider>().changeIndex(newIndex: index);

    // 🚨 ADD THIS: tell the Cubit to refetch the restaurants
    context.read<CategoryCubit>().fetchPopularRestaurants(index);

    widget.onCategoryChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryTitles[selectedIndex!],
                key: ValueKey(selectedIndex),
                style: TextStyles.text900fs28.copyWith(
                  color: context.watch<CategoryProvider>().color,
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
                    categorySubtitles[selectedIndex!],
                    key: ValueKey('subtitle_$selectedIndex'),
                    style: TextStyles.textMediumLarge.black1,
                    maxLines: 3,
                  ),
                ),
              ),
              Gap(15),
              SizedBox(
                width: context.width * 0.38,
                child: ElevatedButton(
                  onPressed: () => onCategorySelected(selectedIndex!),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    backgroundColor: Colours.lightThemeWhite5,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: context.watch<CategoryProvider>().color,
                      ),
                    ),
                  ),
                  child: Text(
                    categoryButton[selectedIndex!],
                    key: ValueKey(selectedIndex),
                    style: TextStyles.textSemiBoldSmall.copyWith(
                      color: context.watch<CategoryProvider>().color,
                    ),
                  ),
                ),
              ),
              Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(categoryImages.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onCategorySelected(index),
                            splashColor: Colours.lightThemeGrey1.withAlpha(25),
                            customBorder: const CircleBorder(),
                            child: Image.asset(
                              categoryImages[index],
                              width: context.width * 0.15,
                              height: context.height * 0.07,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          width: context.width * 0.12,
                          height: 8,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? categoryColors[index]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: context.width * 0.2,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.7, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Container(
                width: context.width * 0.42,
                height: context.width * 0.42,
                // when the key changes the spin will be animated
                key: ValueKey<int>(selectedIndex!),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(swapImages[selectedIndex!]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
