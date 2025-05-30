import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

class PaymentSuccessWidget extends StatelessWidget {
  const PaymentSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Use a flexible space to center the content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Media.paymentFailed),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "Opps, erreur de paiement",
                  style: TextStyles.textSemiBoldLarge.green5,
                ),
                Gap(20),
                AutoSizeText(
                  "Désolé, votre commande n'a pas pu être traitée. Veuillez réessayer le paiement ou revenir à la page d'accueil.",
                  maxLines: 3,
                  style: TextStyles.textRegular.grey1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BuildLogInAndRegButton(
                    "Réessayer le paiement", "nothing", () {}),
                Gap(10),
                TextButton(
                  onPressed: () => context.go(HomePage.routePath),
                  child: Text(
                    "Retour à l'accueil",
                    style: TextStyles.textSemiBold.red5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
