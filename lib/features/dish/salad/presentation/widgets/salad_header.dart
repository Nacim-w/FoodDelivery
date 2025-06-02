import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/dish/pizza/presentation/widgets/pizza_body/threed_page.dart';
import 'package:legy/features/dish/salad/presentation/app/salad_details_provider.dart';
import 'package:provider/provider.dart';

class SaladHeader extends StatefulWidget {
  const SaladHeader({super.key});

  @override
  State<SaladHeader> createState() => _SaladHeaderState();
}

class _SaladHeaderState extends State<SaladHeader> {
  bool isFavorited = false;

  final List<Map<String, String>> salads = [
    {'image': Media.salad1},
    {'image': Media.salad2},
    {'image': Media.salad3},
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SaladDetailsProvider>(context);

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
                  ),
                  const Gap(50),
                ],
              ),
            ),
          ],
        ),

        // Background SVG decoration
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

        // Dish Decoration Image
        Positioned(
          top: context.width * -0.28,
          left: 0,
          child: IgnorePointer(
            child: Image(
              height: context.height * 1,
              width: context.width * 1,
              image: AssetImage(Media.pizzaDecoration),
            ),
          ),
        ),

        // Salad carousel
        Positioned(
          right: 0,
          left: 0,
          top: context.width * 0.4,
          child: SizedBox(
            width: context.width,
            height: context.width * 0.6,
            child: PageView.builder(
              controller: provider.pageController,
              itemCount: salads.length,
              onPageChanged: (index) {
                provider.selectSalad(index);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: context.width * 0.6,
                    height: context.width * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(salads[index]['image']!),
                        fit: BoxFit.contain,
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
