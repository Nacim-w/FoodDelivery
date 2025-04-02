import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

Widget ordersContainer(BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: Colours.lightThemePrimaryColor,
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
                style: TextStyles.textSemiBold,
              ),
              Text(
                "Voir tout",
                style: TextStyles.textSemiBold.orangeSecondary,
              ),
            ],
          ),

          Gap(15),

          // Order ID and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "ID de commande ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "888333777",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colours.lightThemeOrangeSecondaryTextColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "En cours de livraison",
                  style: TextStyle(
                      fontSize: 12, color: Colours.lightThemePrimaryColor),
                ),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "\$ 12,230",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colours.lightThemeOrangeSecondaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "14 articles",
                style: TextStyle(
                    fontSize: 14, color: Colours.lightThemePrimaryTextColor),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
