import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/features/product/presentation/widgets/add_to_cart.dart';
import 'package:legy/features/product/presentation/widgets/product_description.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/product/presentation/widgets/product_recommanded.dart';
import 'package:legy/features/restaurant/model/restaurant_product_model.dart';

class ProductMiddleSection extends StatelessWidget {
  const ProductMiddleSection({super.key, required this.product});
  final RestaurantProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colours.lightThemeWhite4,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                ProductDescription(product: product),
                const Gap(16),
                ProductRecommanded(),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: context.height * 0.14,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colours.lightThemeWhite1,
            child: AddToCart(),
          ),
        ],
      ),
    );
  }
}
