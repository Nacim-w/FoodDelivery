import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/history/model/history_order_models.dart';
import 'package:legy/features/history/model/item_model.dart';

class CurrentOrderWidget extends StatelessWidget {
  final OrderModel order;

  const CurrentOrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colours.lightThemeGreen5,
      dashPattern: const [6, 6],
      strokeWidth: 1.5,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  Media.bestSeller,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.restaurant.name,
                        style: TextStyles.textBoldLarge),
                    Text("Commande n° ${order.orderId}",
                        style: TextStyles.textRegularSmallest),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          ...order.items.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(ItemModel item) {
    final double totalSupplements = item.supplements
        .fold(0.0, (sum, supp) => sum); // Add your supplement logic
    final double total = item.unitPrice * item.quantity + totalSupplements;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colours.lightThemeGreen2.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.productName, style: TextStyles.textMediumSmall.black1),
          const Gap(8),
          Text('${total.toStringAsFixed(2)} CFA',
              style: TextStyles.textSemiBoldLarge.green5),
          const Gap(8),
          Divider(
            color: Colours.lightThemeBlack1.withAlpha(50),
            thickness: 0.5,
          ),
          Row(
            children: [
              Text('Quantité: ${item.quantity}',
                  style: TextStyles.textMediumSmall.black1),
              const SizedBox(width: 16),
              Text('Prix unitaire: ${item.unitPrice.toStringAsFixed(2)}',
                  style: TextStyles.textMediumSmall.black1),
            ],
          ),
          const Gap(10),
          /* for (var supp in item.supplements)
            if (supp.quantity > 0)
              Text("Supp: ${supp.name} x${supp.quantity}",
                  style: TextStyles.textMediumSmall.black1),*/
        ],
      ),
    );
  }
}
