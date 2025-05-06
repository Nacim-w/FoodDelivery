import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/coupons/presentation/widgets/coupon_container.dart';

class CouponView extends StatelessWidget {
  const CouponView({super.key});
  static const routePath = 'couponView';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nos Offres Spéciales',
            style: TextStyles.textSemiBoldLarge.black1,
          ),
          Gap(16),
          CouponContainer(
              name: 'Tacos',
              discription: '3 tacos au prix de 2 chaque mardi.',
              couponCode: 'TACOS10'),
          CouponContainer(
            name: 'Soirée Burger',
            discription:
                ' Chaque jeudi, profitez de n\'importe quel burger gourmet à moitié prix.',
            couponCode: 'BURGER10',
          ),
          CouponContainer(
            name: 'Repas Familial',
            discription:
                'Pizza familiale, pain à l\'ail et soda 2L pour 29,99 CFA.',
            couponCode: 'FAMILY29',
          ),
          CouponContainer(
            name: 'Combo Déjeuner',
            discription:
                'Profitez d\'un sandwich, de chips et d\'une boisson pour seulement 9,99 CFA.',
            couponCode: 'LUNCH99',
          ),
          CouponContainer(
            name: 'Réduction Étudiant de 10%',
            discription:
                'Montrez votre carte et bénéficiez de 10% de réduction.',
            couponCode: 'STUDENT10',
          ),
          CouponContainer(
            name: 'Première commande - Remise',
            discription:
                'Nouveau sur notre plateforme ? -10 CFA  sur votre première commande.',
            couponCode: 'WELCOME10',
          ),
        ],
      ),
    );
  }
}
