import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/product/presentation/widgets/product_review_model.dart';

class ProductActionButton extends StatelessWidget {
  const ProductActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.3,
      child: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colours.lightThemeWhite1.withAlpha(220),
            showDragHandle: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            isScrollControlled: true,
            builder: (context) => const ProductReviewModel(),
          );
        },
        icon: const Icon(Icons.star_rate_rounded),
        label: const Text("Review"),
        backgroundColor: Colours.lightThemeGreen5,
        foregroundColor: Colours.lightThemeWhite1,
        shape: const StadiumBorder(),
        elevation: 6,
        highlightElevation: 12,
      ),
    );
  }
}
