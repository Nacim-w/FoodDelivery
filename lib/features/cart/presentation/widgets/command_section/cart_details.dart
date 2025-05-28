import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/cart/presentation/widgets/cancel_order_content.dart';
import 'package:legy/features/cart/presentation/widgets/command_section/command_card_widget.dart';
import 'package:legy/features/product/model/product_model.dart';

class CartDetails extends StatelessWidget {
  final List<ProductModel> products; // Accepting a list of products
  final List<Supplement> supplements; // Accepting the supplements list

  const CartDetails({
    super.key,
    required this.products,
    required this.supplements,
  });

  @override
  Widget build(BuildContext context) {
    // Filter supplements to only show those with quantity > 0
    final chosenSupplements = supplements
        .where((supplement) =>
            supplement.quantity != null && supplement.quantity! > 0)
        .toList();

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          // Title Row with cancel button
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

          // Display the number of chosen supplements
          Text(
            "Supplements choisis: ${chosenSupplements.length}",
            style: TextStyles.textMediumSmall.black1,
          ),
          Gap(20),

          // Cart Items (Product + Supplements)
          SizedBox(
            height: context.height * 0.55,
            child: ListView(
              children: [
                // Loop through products and pass data to CommandCardWidget
                for (var product in products)
                  CommandCardWidget(
                    product: product, // Pass product data
                    supplements:
                        chosenSupplements, // Pass only supplements with quantity > 0
                  ),
                Gap(20),
              ],
            ),
          ),
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
