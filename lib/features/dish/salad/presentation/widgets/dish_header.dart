import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/salad/presentation/app/dish_details_provider.dart';
import 'package:provider/provider.dart';

class DishHeader extends StatefulWidget {
  const DishHeader({super.key});

  @override
  State<DishHeader> createState() => _DishHeaderState();
}

class _DishHeaderState extends State<DishHeader> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DishDetailsProvider>(context);
    final salads = [
      {'image': Media.salad1},
      {'image': Media.salad2},
      {'image': Media.salad3},
    ];

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
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colours.lightThemeGreen5),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'La table verte',
                        style: TextStyles.titleMediumSmall.green5,
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorited
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colours.lightThemeGreen5,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorited = !isFavorited;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sélectionnez votre favori',
                    style: TextStyles.textMediumLarge.white1,
                  ),
                  Gap(50),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOut,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    layoutBuilder: (Widget? currentChild, List<Widget> _) {
                      return currentChild ?? const SizedBox.shrink();
                    },
                    child: Container(
                      key: ValueKey<int>(provider.selectedSaladIndex),
                      width: context.width * 0.5,
                      height: context.width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              salads[provider.selectedSaladIndex]['image']!),
                        ),
                      ),
                    ),
                  ),
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
                  Colours.lightThemeYellow3.withAlpha(127), BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.04,
          right: context.width * 0.12,
          child: Image(
            height: context.height * 0.6,
            width: context.width * 0.8,
            image: AssetImage(
              Media.dishDecoration,
            ),
          ),
        ),
      ],
    );
  }
}
