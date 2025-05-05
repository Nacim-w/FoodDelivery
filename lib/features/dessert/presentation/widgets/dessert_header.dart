import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dessert/presentation/app/dessert_details_provider.dart';
import 'package:provider/provider.dart';

class DessertHeader extends StatefulWidget {
  const DessertHeader({super.key});

  @override
  State<DessertHeader> createState() => _DessertHeaderState();
}

class _DessertHeaderState extends State<DessertHeader> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DessertDetailsProvider>(context);
    final desserts = [
      {'image': Media.dessert1},
      {'image': Media.dessert2},
      {'image': Media.dessert3},
      {'image': Media.dessert4},
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
                            color: Colours.lightThemeWhite1),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Aux Fins Palais',
                        style: TextStyles.textMediumLarge.white1,
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorited
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colours.lightThemeWhite1,
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
                    style: TextStyles.textMediumLarge.grey1,
                  ),
                  Gap(50),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: context.height * -0.17,
          right: context.width * -0.3,
          child: IgnorePointer(
            child: SvgPicture.asset(
              Media.bgLightRed,
              colorFilter: ColorFilter.mode(
                  Colours.lightThemeRed3.withAlpha(250), BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.3,
          right: context.width * 0.08,
          child: Image(
            height: context.height * 0.2,
            width: context.width * 0.2,
            image: AssetImage(
              Media.redCherry,
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.1,
          left: context.width * 0.01,
          child: Image(
            height: context.height * 0.2,
            width: context.width * 0.2,
            image: AssetImage(
              Media.redCherry,
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.15,
          right: 0,
          child: Image(
            height: context.height * 0.2,
            width: context.width * 0.2,
            image: AssetImage(
              Media.blueCherry,
            ),
          ),
        ),
        Positioned(
          top: context.height * 0.25,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
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
              key: ValueKey<int>(provider.selectedDessertIndex),
              width: context.width * 0.5,
              height: context.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                      desserts[provider.selectedDessertIndex]['image']!),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
