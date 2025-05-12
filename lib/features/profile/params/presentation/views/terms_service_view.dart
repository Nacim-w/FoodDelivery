import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';

class TermsServiceView extends StatelessWidget {
  const TermsServiceView({super.key});
  static const routePath = 'terms-service';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlackAppBar(
          title: 'Rendez-vous personnel',
          onTap: context.pop,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confidentialité d\'annulation',
                  style: TextStyles.textSemiBold.green5,
                ),
                Text(
                  'Lors d\'une annulation, nous collectons uniquement les informations nécessaires '
                  'pour traiter votre demande. Ces données sont utilisées exclusivement pour la '
                  'gestion de l\'annulation et le respect de nos politiques. Vos informations '
                  'personnelles ne sont jamais partagées avec des tiers, sauf avec les partenaires '
                  'impliqués dans l\'annulation, conformément à la législation. Nous protégeons vos '
                  'données et garantissons leur utilisation sécurisée et transparente.',
                  style: TextStyles.textRegularSmall.black1,
                ),
                Text(
                  'Termes et conditions',
                  style: TextStyles.textSemiBold.green5,
                ),
                Text(
                  'En utilisant notre application, vous acceptez de respecter et de vous conformer aux présents termes '
                  'et conditions d\'utilisation. Ces conditions régissent votre accès, votre utilisation et vos interactions '
                  'avec nos services, incluant les achats, annulations, retours, ainsi que toutes les transactions effectuées '
                  'via notre plateforme. Nous nous réservons le droit de modifier, mettre à jour ou réviser ces termes à '
                  'tout moment, et vous êtes responsable de consulter régulièrement cette section pour prendre connaissance '
                  'de ces changements.\n\n'
                  'Vous vous engagez à ne pas utiliser nos services à des fins illégales ou interdites par ces termes et à '
                  'respecter les lois en vigueur dans votre pays de résidence. En cas de non-respect de ces termes, nous '
                  'nous réservons le droit de suspendre ou de résilier votre compte sans préavis.\n\n'
                  'Notre politique d’annulation et de retour est régie par des conditions spécifiques, détaillées dans cette '
                  'section. Les utilisateurs doivent suivre les procédures de retour et d’annulation telles que décrites, en '
                  'tenant compte des délais et conditions précis. Toutes les informations collectées sont traitées selon '
                  'notre politique de confidentialité, qui est intégrée à ces termes et conditions.\n\n'
                  'En utilisant notre plateforme, vous acceptez que nous puissions collecter et utiliser vos données personnelles '
                  'conformément à notre politique de confidentialité. Nous mettons tout en œuvre pour assurer la sécurité de vos '
                  'informations, mais nous ne pouvons être tenus responsables des risques liés à des actions de tiers.',
                  style: TextStyles.textRegularSmall.black1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
