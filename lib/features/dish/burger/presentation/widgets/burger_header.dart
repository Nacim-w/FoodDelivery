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
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/threed_page.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: context.width * 0.1,
                            height: context.width * 0.1,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colours.lightThemeGreen5,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colours.lightThemeBlack1.withAlpha(70),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SvgPicture.asset(Media.categoryArrow),
                            ),
                          ),
                        ),

                        // Title with green text
                        Text(
                          'Le Coin des Burgers',
                          style: TextStyles.textSemiBoldLarge.white1,
                        ),

                        // Favorite button with green background + shadow
                        Container(
                          width: context.width * 0.1,
                          height: context.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colours.lightThemeGreen5,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colours.lightThemeBlack1.withAlpha(70),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
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
                            iconSize: context.width * 0.06,
                          ),
                        ),
                      ],
                    ),
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
                    width: context.width * 0.7,
                    height: context.width * 0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(burgers[index]['image']!),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: context.width * 1.1,
          left: 16,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => My3DViewer(asset: Media.pizza3d),
                ),
              );
            },
            icon: const Icon(Icons.threed_rotation),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colours.lightThemeWhite1,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colours.lightThemeGreen5,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
