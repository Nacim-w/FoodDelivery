import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/restaurant/presentation/views/all_restaurants_view.dart';

class EmptyCartView extends StatelessWidget {
  static const routePath = 'emptyCart';

  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlackAppBar(title: 'Mon Panier', onTap: context.pop),
        ),
        Gap(100),
        Image.asset(Media.emptyCart),
        Gap(40),
        Text("Aïe ! J'ai faim !", style: TextStyles.titleMediumSmall.black2),
        Gap(15),
        SizedBox(
          width: context.width * 0.7,
          height: context.height * 0.1,
          child: AutoSizeText(
            "Il semble que vous n'ayez pas encore commandé de nourriture.",
            textAlign: TextAlign.center,
            style: TextStyles.textMediumLarge.grey1,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: BuildLogInAndRegButton(
            "Trouver des plats",
            "none",
            () => context
                .push('${HomePage.routePath}/${AllRestaurantsView.routePath}'),
          ),
        ),
      ],
    );
  }
}
