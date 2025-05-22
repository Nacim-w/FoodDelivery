import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/product/presentation/widgets/product_appbar.dart';

import 'package:legy/features/product/presentation/widgets/product_cover.dart';
import 'package:legy/features/product/presentation/widgets/product_middle_section.dart';
import 'package:legy/features/restaurant/model/restaurant_product_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});
  static const routePath = 'Product';

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    //getting the specific product detail here
    final product = GoRouterState.of(context).extra as RestaurantProductModel;
    return Stack(
      children: [
        ProductCover(image: product.imageUrl),
        Positioned(
          child: Padding(
              padding: const EdgeInsets.only(top: 35, left: 16, right: 16),
              child: ProductAppbar()),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(63),
                topRight: Radius.circular(63),
              ),
            ),
            child: ProductMiddleSection(product: product),
          ),
        ),
      ],
    );
  }
}
