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

    // Get current cart data
    final currentProducts = cacheHelper.getCartProducts();
    final currentSupplements = cacheHelper.getCartSupplements();

    // Add the new product (if not already in the cart, or update quantity if it is)
    final existingProductIndex =
        currentProducts.indexWhere((p) => p.id == widget.product.id);

    if (existingProductIndex >= 0) {
      currentProducts[existingProductIndex].quantity += widget.product.quantity;
    } else {
      currentProducts.add(widget.product);
    }

    // Add the supplements (naively appending; you may want to merge quantities if needed)
    currentSupplements.addAll(widget.supplements);

    // Save back to cache
    await cacheHelper.cacheCartProducts(currentProducts);
    await cacheHelper.cacheCartSupplements(currentSupplements);

    // Navigate to cart page
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
