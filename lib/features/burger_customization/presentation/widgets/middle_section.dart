import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class MiddleSection extends StatefulWidget {
  const MiddleSection({super.key});

  @override
  State<MiddleSection> createState() => _MiddleSectionState();
}

class _MiddleSectionState extends State<MiddleSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: context.width * 0.7,
            height: context.height * 0.35,
            decoration: BoxDecoration(
              color: Colours.lightThemeOrange5,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colours.lightThemeYellow5,
                  blurRadius: 0.5,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colours.lightThemeYellow5,
                  blurRadius: 0.5,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
          ),
          Positioned(
            top: context.height * 0.12,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  'Commencez à créer votre burger',
                  textAlign: TextAlign.center,
                  style: TextStyles.titleMediumSmall.white1,
                  maxLines: 3,
                ),
                AutoSizeText(
                  'Sélectionnez les ingrédients ci-dessous pour concevoir votre propre burger.',
                  textAlign: TextAlign.center,
                  style: TextStyles.textMedium.white1,
                  maxLines: 3,
                ),
                Gap(20),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value),
                      child: SvgPicture.asset(
                        Media.helperArrow,
                        height: 40,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: context.height * 0.08,
            left: context.width * 0.05,
            child: Image.asset(
              Media.burgerBackground,
              width: context.width * 0.6,
              height: context.height * 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
