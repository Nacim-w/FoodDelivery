import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/features/product/presentation/widgets/add_to_cart.dart';
import 'package:legy/features/product/presentation/widgets/product_description.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/product/presentation/widgets/product_recommanded.dart';
import 'package:legy/features/product/presentation/widgets/supplement_selector.dart';

class ProductMiddleSection extends StatelessWidget {
  const ProductMiddleSection({super.key, required this.product});
  final ProductModel product;

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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  ProductDescription(product: product),
                  const Gap(16),
                  SupplementsSelector(
                    supplements: product.supplements,
                  ),
                  const Gap(16),
                  ProductRecommanded(),
                ],
              ),
            ),
          ),

          // Pass the product and supplements to AddToCart widget
          Container(
            height: context.height * 0.14,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colours.lightThemeWhite1,
            child: AddToCart(
              product: product,
              supplements: product.supplements, // Send supplements here
            ),
          ),
        ],
      ),
    );
  }
}
