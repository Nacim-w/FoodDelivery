import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/res/styles/colours.dart';
import 'package:legy/common/res/styles/text.dart';

class OrdersContainer extends StatelessWidget {
  const OrdersContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colours.lightThemeWhite1,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mes commandes",
                  style: TextStyles.textMediumLarge,
                ),
                Text(
                  "Voir tout",
                  style: TextStyles.textMedium.orange5,
                ),
              ],
            ),
            Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "ID de commande ",
                    style: TextStyles.textMediumSmall.grey1,
                    children: [
                      TextSpan(
                        text: "888333777",
                        style: TextStyles.textMediumSmall.black1,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colours.lightThemeOrange5,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("En cours de livraison",
                      style: TextStyles.textMediumSmallest.white1),
                ),
              ],
            ),
            Gap(8),
            Divider(),
            Gap(8),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    Media.order,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Burger With Meat",
                        style: TextStyles.textMedium.black1,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "12,230 CFA",
                        style: TextStyles.textMedium.orange5,
                      ),
                    ],
                  ),
                ),
                Text(
                  "14 articles",
                  style: TextStyles.textMediumSmall.black1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
