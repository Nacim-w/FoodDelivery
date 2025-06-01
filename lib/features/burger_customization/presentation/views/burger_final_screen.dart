import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/green_app_bar.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class BurgerFinalScreen extends StatelessWidget {
  static const routePath = "burger_finished";

  final List<String> ingredients;

  const BurgerFinalScreen({super.key, required this.ingredients});

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
            child: GreenAppBar(title: 'Burger', onTap: context.pop),
          ),
          Column(
            children: [
              Text(
                "Yaaayyy !!",
                style: TextStyles.titleSemiBold.green5,
              ),
              Text(
                "Votre burger est prêt.",
                style: TextStyles.titleMediumSmallest.white1,
              ),
              const Gap(20),
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
                        if (ingredients.contains(Media.burgerBottomBun))
                          Positioned(
                            bottom: 0,
                            child: Image.asset(
                              Media.burgerBottomBun,
                              width: context.width * 0.6,
                            ),
                          ),
                        for (int i = 0; i < ingredients.length; i++)
                          if (ingredients[i] != Media.burgerBottomBun &&
                              ingredients[i] != Media.burgerTopBun)
                            Positioned(
                              bottom: (i + 1) * 15, // reduced gap
                              child: Transform.scale(
                                scale: 1.0 - (i * 0.02),
                                child: Image.asset(
                                  ingredients[i],
                                  width: context.width * 0.6,
                                ),
                              ),
                            ),
                        if (ingredients.contains(Media.burgerTopBun))
                          Positioned(
                            bottom: ingredients.length * 15 + 10,
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
                  child: Text(
                    ingredients
                        .map((path) =>
                            path.split('/').last.replaceAll('.png', ''))
                        .join(", "),
                    style: TextStyles.textMedium.white1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: context.height * 0.1,
                color: Colours.lightThemeWhite1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$135.50', style: TextStyles.titleMediumSmall.black1),
                    Gap(20),
                    RoundedButton(
                      text: '',
                      widgetContentButton: Row(
                        children: [
                          Text(
                            'Ajouter au panier',
                            style: TextStyles.textSemiBoldLarge.white1,
                          ),
                          Gap(10),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 25,
                          ),
                        ],
                      ),
                      width: context.width * 0.6,
                      height: context.height * 0.06,
                      backgroundColour: Colours.lightThemeOrange5,
                      onPressed: () => context.go(
                          '${HomePage.routePath}/${FullCartView.routePath}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
