import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
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
          '$quantity',
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
          onPressed: () {},
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
