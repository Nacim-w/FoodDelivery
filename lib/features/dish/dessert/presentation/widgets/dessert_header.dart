import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/dessert/presentation/app/dessert_details_provider.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/threed_page.dart';
import 'package:provider/provider.dart';

class DessertHeader extends StatefulWidget {
  const DessertHeader({super.key});

  @override
  State<DessertHeader> createState() => _DessertHeaderState();
}

class _DessertHeaderState extends State<DessertHeader> {
  bool isFavorited = false;

  final List<Map<String, String>> desserts = [
    {'image': Media.dessert4},
    {'image': Media.dessert2},
    {'image': Media.dessert3},
    {'image': Media.dessert1},
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DessertDetailsProvider>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              color: Colours.lightThemeBlack0,
              width: context.width,
              height: context.height * 0.8,
              child: Column(
                children: [
                  context.adaptiveGap,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button styled like SaladHeader / BuildHeaderBar
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: context.width * 0.1,
                            height: context.width * 0.1,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colours.lightThemeBrown4,
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

                        // Title text with green style
                        Text(
                          'Aux Fins Palais',
                          style: TextStyles.textSemiBoldLarge.white1,
                        ),

                        // Favorite button styled similarly
                        Container(
                          width: context.width * 0.1,
                          height: context.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colours.lightThemeBrown4,
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
                              size: context.width * 0.06,
                            ),
                            onPressed: () {
                              setState(() {
                                isFavorited = !isFavorited;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(50),
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
            image: AssetImage(Media.redCherry),
          ),
        ),
        Positioned(
          top: context.height * 0.1,
          left: context.width * 0.01,
          child: Image(
            height: context.height * 0.2,
            width: context.width * 0.2,
            image: AssetImage(Media.redCherry),
          ),
        ),
        Positioned(
          top: context.height * 0.15,
          right: 0,
          child: Image(
            height: context.height * 0.2,
            width: context.width * 0.2,
            image: AssetImage(Media.blueCherry),
          ),
        ),
        Positioned(
          top: context.height * 0.28,
          left: 0,
          child: SizedBox(
            width: context.width,
            height: context.width * 0.7,
            child: PageView.builder(
              controller: provider.pageController,
              itemCount: desserts.length,
              onPageChanged: (index) {
                provider.setSelectedDessertIndex(index);
              },
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: context.width * 0.7,
                    height: context.width * 0.7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(desserts[index]['image']!),
                        fit: BoxFit.cover,
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
          right: 16,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => My3DViewer(
                    asset: Media.cupcake3d,
                  ),
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
                  color: Colours.lightThemeBrown3,
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
