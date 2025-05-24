import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/features/order/presentation/widgets/command_section/command_card_widget.dart';
import 'package:legy/features/order/presentation/widgets/details_section/details_widget.dart';
import 'package:legy/features/order/presentation/widgets/payment_section/payment_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';
import 'package:legy/features/product/model/product_model.dart';

class FullCart extends StatefulWidget {
  static const routePath = 'fullCart';

  final List<ProductModel> products;
  final List<Supplement> supplements;

  const FullCart({
    super.key,
    required this.products,
    required this.supplements,
  });

  @override
  State<FullCart> createState() => _FullCartWidgetState();
}

class _FullCartWidgetState extends State<FullCart> {
  double calculateTotalPrice() {
    double total = 0;

    // Calculate price for products
    for (var product in widget.products) {
      total += product.pricePostCom * (product.quantity);
    }

    // Calculate price for supplements
    for (var supplement in widget.supplements) {
      total += supplement.price * (supplement.quantity ?? 1);
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();

    return Column(
      children: [
        Gap(40),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ProfileSettingsAppbar(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...widget.products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommandCardWidget(
                      product: product,
                      supplements: widget.supplements,
                    ),
                  );
                }),
                Gap(20),
                DetailsWidget(),
                PaymentWidget(totalPrice: totalPrice),
                Gap(20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
