import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/order/full_cart/sections/payment_section/payment_button_widget.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sous-total",
                style: TextStyles.textMediumLarge.black,
              ),
              Text(
                "31.50 CFA",
                style: TextStyles.textMediumLarge.black,
              ),
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frais de livraison",
                style: TextStyles.textMediumLarge.black,
              ),
              Text(
                "FREE",
                style: TextStyles.textMediumLarge.black,
              ),
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remise",
                style: TextStyles.textMediumLarge.black,
              ),
              Text(
                "-6.30 CFA",
                style: TextStyles.textMediumLarge.black,
              ),
            ],
          ),
          Divider(
            color: Colours.lightThemePrimaryTextColor,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyles.textMediumLargest,
              ),
              Text(
                "25.20 CFA",
                style: TextStyles.textMediumLargest,
              )
            ],
          ),
          Gap(10),
          PaymentButtonWidget(),
        ],
      ),
    );
  }
}
