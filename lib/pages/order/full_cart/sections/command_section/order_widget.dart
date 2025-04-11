import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/pages/order/full_cart/sections/command_section/order_card__full_widget.dart';
import 'package:testing/pages/order/full_cart/sections/command_section/order_card_empty_widget.dart';

class Command extends StatefulWidget {
  const Command({super.key});

  @override
  State<Command> createState() => _CommandState();
}

class _CommandState extends State<Command> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Détails commande",
                style: TextStyles.textMediumLarge.black,
              ),
              GestureDetector(
                onTap: () {
                  context.push(Routes.homePage);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colours.lightThemeRedTextColor),
                  ),
                  child: Center(
                    child: Text(
                      "Annuler la commande",
                      style: TextStyles.textMediumSmall.red,
                    ),
                  ),
                ),
              )
            ],
          ),
          Gap(20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: ListView(
              children: [
                CommandCardWidget(
                  name: "chicken burger",
                  price: 10.00,
                  image: Media.burger,
                  discounted: 6.00,
                ),
                Gap(20),
                CommandCardEmpty(
                  name: "Ramen Noodles",
                  price: 22.00,
                  image: Media.ramenNoodles,
                  discounted: 15.0,
                ),
                Gap(20),
                CommandCardEmpty(
                  name: "Ramen Noodles",
                  price: 22.00,
                  image: Media.ramenNoodles,
                  discounted: 15.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
