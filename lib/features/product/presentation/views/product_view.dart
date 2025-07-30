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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final product = state.product!;

        return Scaffold(
          extendBody: true,
          body: Column(
            children: [
              ProductCover(image: product.imageUrl),
              Padding(
                padding: EdgeInsets.only(
                  top: Platform.isAndroid ? 10 : 30,
                ),
                child: ProductAppbar(productId: product.id),
              ),
              Expanded(
                child: ProductMiddleSection(product: product),
              ),
            ],
          ),
        );
      },
    );
  }
}
