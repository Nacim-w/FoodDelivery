import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order/full_cart/sections/command_section/order_card__full_widget.dart';
import 'package:legy/features/order/full_cart/sections/command_section/order_card_empty_widget.dart';
import 'package:legy/features/order/full_cart/widgets/cancel_order_content.dart';

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
                style: TextStyles.textMediumLarge.black1,
              ),
              OutlinedButton(
                onPressed: () => showCancelModal(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colours.lightThemeRed5),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size(20, 30),
                ),
                child: Text(
                  "Annuler la commande",
                  style: TextStyles.textMediumSmall.red5,
                ),
              ),
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

  void showCancelModal(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const CancelOrderContent();
      },
    );
  }
}
