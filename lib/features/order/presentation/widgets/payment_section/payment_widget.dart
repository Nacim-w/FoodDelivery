import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order/presentation/widgets/payment_section/payment_button_widget.dart';

class PaymentWidget extends StatefulWidget {
  final double totalPrice;

  const PaymentWidget({super.key, required this.totalPrice});

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
                style: TextStyles.textMediumLarge.black2,
              ),
              Text(
                "${widget.totalPrice} CFA",
                style: TextStyles.textMediumLarge.black2,
              ),
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frais de livraison",
                style: TextStyles.textMediumLarge.black2,
              ),
              Text(
                "FREE",
                style: TextStyles.textMediumLarge.black2,
              ),
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Remise",
                style: TextStyles.textMediumLarge.black2,
              ),
              Text(
                "-6.30 CFA",
                style: TextStyles.textMediumLarge.black2,
              ),
            ],
          ),
          Divider(
            color: Colours.lightThemeBlack2,
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
                "${widget.totalPrice - 6.30} CFA", // Applying the discount
                style: TextStyles.textMediumLargest,
              )
            ],
          ),
          Gap(10),
          PaymentButtonWidget(totalPrice: widget.totalPrice - 6.30),
        ],
      ),
    );
  }
}
