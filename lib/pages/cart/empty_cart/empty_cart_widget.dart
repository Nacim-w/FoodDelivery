import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/build_login_reg_widget.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(100),
        Image.asset(Media.emptyCart),
        Gap(40),
        Text("Aïe ! J'ai faim !", style: TextStyles.titleMediumSmall.black),
        Gap(15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 100,
          child: AutoSizeText(
            "Il semble que vous n'ayez pas encore commandé de nourriture.",
            textAlign: TextAlign.center,
            style: TextStyles.textMediumLarge.grey,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: BuildLogInAndRegButton("Trouver des plats", "none", () {}),
        ),
      ],
    );
  }
}
