import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/features/product/presentation/app/product_cubit.dart';
import 'package:legy/features/product/presentation/app/product_state.dart';

class SupplementsSelector extends StatelessWidget {
  final List<Supplement> supplements;

  const SupplementsSelector({super.key, required this.supplements});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final product = state.product;

        // Check that loading is complete and product is not null
        if (!state.isLoading && product != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Choose Supplements',
                  style: TextStyles.titleMediumTiny.black1,
                ),
              ),
              ...product.supplements.map(
                (supp) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colours.lightThemeOrange0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Supplement Name
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            supp.name,
                            style: TextStyles.textMedium.black1,
                          ),
                        ),
                      ),

                      // Quantity Selector (from 0 to 99)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              int currentQuantity = supp.quantity ?? 0;
                              if (currentQuantity > 0) {
                                context
                                    .read<ProductCubit>()
                                    .updateSupplementQuantity(
                                        supp.id, currentQuantity - 1);
                              }
                            },
                          ),
                          SizedBox(
                            width: context.width * 0.08,
                            child: Center(
                              // Center aligns the number
                              child: Text(
                                '${supp.quantity ?? 0}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFeatures: [
                                    FontFeature.tabularFigures()
                                  ], // Monospaced digits
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              int currentQuantity = supp.quantity ?? 0;
                              if (currentQuantity < 99) {
                                context
                                    .read<ProductCubit>()
                                    .updateSupplementQuantity(
                                        supp.id, currentQuantity + 1);
                              }
                            },
                          ),
                        ],
                      ),

                      // Fixed width for Price (prevents shifting)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            '${(supp.price * (supp.quantity ?? 1)).toStringAsFixed(2)} CFA',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        // Return empty widget if loading or product is null
        return const SizedBox.shrink();
      },
    );
  }
}
