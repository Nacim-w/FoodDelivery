import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class BurgerFinalScreen extends StatefulWidget {
  static const routePath = "burger_finished";

  final List<String> ingredients;

  const BurgerFinalScreen({super.key, required this.ingredients});

  @override
  State<BurgerFinalScreen> createState() => _BurgerFinalScreenState();
}

class _BurgerFinalScreenState extends State<BurgerFinalScreen> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.lightThemeBlack1,
      child: Column(
        children: [
          context.adaptiveGap,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0)
                .copyWith(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                InkWell(
                  onTap: () => context.pop(),
                  child: Container(
                    width: context.width * 0.1,
                    height: context.width * 0.1,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colours.lightThemeOrange5,
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

                // Title
                Text(
                  'Burger',
                  style: TextStyles.titleBold.white1,
                ),

                // Favorite icon
                Container(
                  width: context.width * 0.1,
                  height: context.width * 0.1,
                  decoration: BoxDecoration(
                    color: Colours.lightThemeOrange5,
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
          Column(
            children: [
              Gap(30),
              Text(
                "Yaaayyyy !!",
                style: TextStyles.titleBold.orange5,
              ),
              Gap(10),
              Text(
                "Votre burger est prêt.",
                style: TextStyles.titleMediumSmallest.white1,
              ),
              SizedBox(
                height: context.height * 0.3,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: context.width * 0.6,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (widget.ingredients.contains(Media.burgerBottomBun))
                          Positioned(
                            bottom: 0,
                            child: Image.asset(
                              Media.burgerBottomBun,
                              width: context.width * 0.6,
                            ),
                          ),
                        for (int i = 0; i < widget.ingredients.length; i++)
                          if (widget.ingredients[i] != Media.burgerBottomBun &&
                              widget.ingredients[i] != Media.burgerTopBun)
                            Positioned(
                              bottom: (i + 1) * 15, // reduced gap
                              child: Transform.scale(
                                scale: 1.0 - (i * 0.02),
                                child: Image.asset(
                                  widget.ingredients[i],
                                  width: context.width * 0.6,
                                ),
                              ),
                            ),
                        if (widget.ingredients.contains(Media.burgerTopBun))
                          Positioned(
                            bottom: widget.ingredients.length * 15 + 10,
                            child: Image.asset(
                              Media.burgerTopBun,
                              width: context.width * 0.6,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Align(
                alignment: Alignment.center,
                child: Text("Recipe:", style: TextStyles.textMedium.white1),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: context.height * 0.2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.ingredients
                        .map((path) =>
                            path.split('/').last.replaceAll('.png', ''))
                        .join(", "),
                    style: TextStyles.textMedium.white1,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: context.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$135.50', style: TextStyles.titleSemiBold.white1),
                      RoundedButton(
                        text: '',
                        widgetContentButton: Row(
                          children: [
                            Text(
                              'Ajouter au panier',
                              style: TextStyles.textSemiBoldLarge.white1,
                            ),
                            const Gap(10),
                            const Icon(
                              Icons.arrow_forward_sharp,
                              size: 25,
                            ),
                          ],
                        ),
                        width: context.width * 0.6,
                        height: context.height * 0.05,
                        backgroundColour: Colours.lightThemeOrange5,
                        onPressed: () => context.go(
                            '${HomePage.routePath}/${FullCartView.routePath}'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
