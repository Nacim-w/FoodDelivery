import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/product/presentation/app/product_cubit.dart';
import 'package:legy/features/product/presentation/app/product_state.dart';

class ProductAppbar extends StatelessWidget {
  final String productId;

  const ProductAppbar({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final isFavorite = state.isFavorite;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colours.lightThemeWhite1,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: context.width * 0.1,
                  height: context.width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colours.lightThemeOrange5,
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: context.width * 0.05,
                      color: Colours.lightThemeOrange5,
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colours.lightThemeWhite1,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  context.read<ProductCubit>().toggleFavoriteStatus(productId);
                },
                child: Container(
                  width: context.width * 0.1,
                  height: context.width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colours.lightThemeOrange5,
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: context.width * 0.05,
                      color: Colours.lightThemeOrange5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
