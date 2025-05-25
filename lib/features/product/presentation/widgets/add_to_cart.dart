import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/order/presentation/views/full_cart_widget.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCart extends StatefulWidget {
  final ProductModel product;
  final List<Supplement> supplements;

  const AddToCart({
    super.key,
    required this.product,
    required this.supplements,
  });

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  void increment() {
    setState(() {
      widget.product.quantity++;
    });
  }

  void decrement() {
    if (widget.product.quantity > 1) {
      setState(() {
        widget.product.quantity--;
      });
    }
  }

  Future<void> addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);

    final currentProducts = cacheHelper.getCartProducts();
    final newProductRestaurantId = widget.product.restaurantId;

    bool shouldClearCart = false;

    if (currentProducts.isNotEmpty) {
      final existingRestaurantId = currentProducts.first.restaurantId;
      if (existingRestaurantId != newProductRestaurantId) {
        // Show confirmation dialog
        final confirmClear = await showDialog<bool>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colours.lightThemeWhite1,
            title: Text(
              'Changer de restaurant ?',
              style: TextStyles.textBoldLarge.black1,
            ),
            content: Text(
              'Votre panier contient des articles d\'un autre restaurant. '
              'Voulez-vous vider le panier et continuer ?',
              style: TextStyles.textMedium.black1,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(
                  'Annuler',
                  style: TextStyles.textMedium.black1,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(
                  'Oui, vider',
                  style: TextStyles.textMedium.orange5,
                ),
              ),
            ],
          ),
        );

        if (confirmClear == true) {
          shouldClearCart = true;
        } else {
          // User cancelled → do nothing
          return;
        }
      }
    }

    if (shouldClearCart) {
      await cacheHelper.clearCart();
      currentProducts.clear();
    }

    // Prepare product with selected supplements
    final productWithSelectedSupplements = widget.product.copyWith(
      supplements: widget.supplements,
    );

    // Check if product already exists
    final existingIndex =
        currentProducts.indexWhere((p) => p.id == widget.product.id);

    if (existingIndex >= 0) {
      final existingProduct = currentProducts[existingIndex];
      final updatedQuantity =
          existingProduct.quantity + widget.product.quantity;

      final updatedSupplements = [
        ...existingProduct.supplements,
        ...widget.supplements,
      ];

      final updatedProduct = existingProduct.copyWith(
        quantity: updatedQuantity,
        supplements: updatedSupplements,
      );

      currentProducts[existingIndex] = updatedProduct;
    } else {
      currentProducts.add(productWithSelectedSupplements);
    }

    // Save back to cache
    await cacheHelper.cacheCartProducts(currentProducts);

    // Navigate to cart page
    // ignore: use_build_context_synchronously
    context.push('${HomePage.routePath}/${FullCart.routePath}');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colours.lightThemeWhite1,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colours.lightThemeGrey2,
              width: 0.3,
            ),
          ),
          child: IconButton(
            onPressed: decrement,
            icon: const Icon(Icons.remove),
          ),
        ),
        Text(
          '${widget.product.quantity}',
          style: TextStyles.textSemiBoldLargest.black1,
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colours.lightThemeWhite1,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colours.lightThemeGrey2,
              width: 0.3,
            ),
          ),
          child: IconButton(
            onPressed: increment,
            icon: const Icon(Icons.add),
          ),
        ),
        RoundedButton(
          text: '',
          onPressed: addToCart,
          width: context.width * 0.55,
          height: 50,
          widgetContentButton: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              Gap(10),
              Text(
                'Ajouter au panier',
                style: TextStyles.textSemiBold.copyWith(color: Colors.white),
              ),
            ],
          ),
          backgroundColour: Colours.lightThemeOrange5,
        ),
      ],
    );
  }
}
