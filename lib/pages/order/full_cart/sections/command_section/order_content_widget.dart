import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/auth/auth_widgets/build_login_reg_widget.dart';

class OrderContentWidget extends StatelessWidget {
  const OrderContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Votre commande annulée",
          style: TextStyles.textMediumLargest.black1,
          textAlign: TextAlign.center,
        ),
        Gap(15),
        Image.asset(Media.heart),
        AutoSizeText(
          "Nous sommes désolés de voir votre commande annulée.",
          style: TextStyles.textMediumLarge.black1,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "On revient encore meilleurs !",
            style: TextStyles.textMediumLarge.grey1,
            textAlign: TextAlign.center,
          ),
        ),
        Gap(20),
        BuildLogInAndRegButton("Ok", "buttonType", () {}),
      ],
    );
  }
}
