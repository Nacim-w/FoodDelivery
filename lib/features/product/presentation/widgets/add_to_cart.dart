import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/order/presentation/views/full_cart_widget.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:go_router/go_router.dart'; // Add GoRouter import

class AddToCart extends StatefulWidget {
  final ProductModel product;
  final List<Supplement> supplements;

  const AddToCart(
      {super.key, required this.product, required this.supplements});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  // Increment and decrement logic for product quantity
  void increment() {
    setState(() {
      widget.product.quantity++; // Update the product's quantity directly
    });
  }

  void decrement() {
    if (widget.product.quantity > 1) {
      setState(() {
        widget.product.quantity--; // Update the product's quantity directly
      });
    }
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
          '${widget.product.quantity}', // Display product quantity
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
          onPressed: () {
            // Send product and supplements to another page
            context.push(
              '${HomePage.routePath}/${FullCart.routePath}', // The target route
              extra: {
                'products': [widget.product],
                'supplements': widget.supplements, // Supplements data
              },
            );
          },
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
