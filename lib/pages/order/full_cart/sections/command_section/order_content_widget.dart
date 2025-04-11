import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/build_login_reg_widget.dart';

class OrderContentWidget extends StatelessWidget {
  const OrderContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Votre commande annulée",
          style: TextStyles.textMediumLargest.black,
          textAlign: TextAlign.center,
        ),
        Gap(15),
        Image.asset(Media.heart),
        AutoSizeText(
          "Nous sommes désolés de voir votre commande annulée.",
          style: TextStyles.textMediumLarge.black,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            "On revient encore meilleurs !",
            style: TextStyles.textMediumLarge.grey,
            textAlign: TextAlign.center,
          ),
        ),
        Gap(20),
        BuildLogInAndRegButton("Ok", "buttonType", () {}),
      ],
    );
  }
}
