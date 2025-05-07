import 'package:flutter/material.dart';

import 'package:legy/features/product/presentation/widgets/product_cover.dart';
import 'package:legy/features/product/presentation/widgets/product_middle_section.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});
  static const routePath = 'Product';

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ProductCover(),
          ],
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
            child: ProductMiddleSection(),
          ),
        ),
      ],
    );
  }
}
