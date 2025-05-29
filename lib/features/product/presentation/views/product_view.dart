import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/product/presentation/app/product_cubit.dart';
import 'package:legy/features/product/presentation/app/product_state.dart';
import 'package:legy/features/product/presentation/widgets/product_appbar.dart';
import 'package:legy/features/product/presentation/widgets/product_cover.dart';
import 'package:legy/features/product/presentation/widgets/product_middle_section.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.productId});
  final String productId;
  static const routePath = 'Product';

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProductCubit>();
    cubit.loadProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.isLoading || state.product == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final product = state.product!;
        return Stack(
          children: [
            BlocSelector<ProductCubit, ProductState, String>(
              selector: (state) => state.product!.imageUrl,
              builder: (context, imageUrl) {
                return ProductCover(image: imageUrl);
              },
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                    top: Platform.isAndroid ? 30 : 60, left: 16, right: 16),
                child: ProductAppbar(productId: product.id),
              ),
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
      },
    );
  }
}