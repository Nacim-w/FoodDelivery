import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/widgets/payment_section/order_button_widget.dart';
import 'package:legy/features/product/model/product_model.dart';

class PaymentWidget extends StatefulWidget {
  final double totalPrice;
  final List<ProductModel> products;

  const PaymentWidget(
      {super.key, required this.totalPrice, required this.products});

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
                "0 CFA",
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
                "${widget.totalPrice} CFA", // Applying the discount
                style: TextStyles.textMediumLargest,
              )
            ],
          ),
          Gap(10),
          OrderButtonWidget(
            totalPrice: widget.totalPrice,
            products: widget.products,
          ),
        ],
      ),
    );
  }
}
