import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandCardWidget extends StatefulWidget {
  final ProductModel product;
  final List<Supplement> supplements;
  final VoidCallback? onRemoved; // Callback to notify parent

  const CommandCardWidget({
    super.key,
    required this.product,
    required this.supplements,
    this.onRemoved,
  });

  @override
  State<CommandCardWidget> createState() => _CommandCardWidgetState();
}

class _CommandCardWidgetState extends State<CommandCardWidget> {
  late int productQuantity;
  late Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
    productQuantity = widget.product.quantity;
    _decodeImage();
  }

  @override
  void didUpdateWidget(covariant CommandCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.product.imageUrl != oldWidget.product.imageUrl) {
      _decodeImage();
    }
  }

  void _decodeImage() {
    final base64Str = widget.product.imageUrl.split(',').last;
    imageBytes = base64Decode(base64Str);
  }

  void increment() {
    setState(() {
      productQuantity++;
    });
  }

  void decrement() {
    if (productQuantity > 1) {
      setState(() {
        productQuantity--;
      });
    }
  }

  Future<void> removeProductFromCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);

    // Get current cart products
    final currentProducts = cacheHelper.getCartProducts();

    // Remove the product by ID
    currentProducts.removeWhere((p) => p.id == widget.product.id);

    // Save updated list back to cache
    await cacheHelper.cacheCartProducts(currentProducts);

    // Optional: Notify parent widget to reload cart
    if (widget.onRemoved != null) {
      widget.onRemoved!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeSupplements = widget.supplements
        .where((supplement) =>
    supplement.quantity != null && supplement.quantity! > 0)
        .toList();

    double productTotal = productQuantity * widget.product.pricePreCom;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colours.lightThemeWhite1,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colours.lightThemeGrey2.withAlpha(127),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(10),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: MemoryImage(imageBytes),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyles.textMediumSmall.black1,
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Text(
                            '$productTotal CFA ',
                            style: TextStyles.textMediumLarge.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colours.lightThemeGrey1,
                            ),
                          ),
                          Text(
                            '$productTotal CFA',
                            style: TextStyles.textMediumLarge.red5,
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colours.lightThemeGrey2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colours.lightThemeOrange5,
                                onPressed: decrement,
                                iconSize: 12,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            productQuantity.toString(),
                            style: TextStyles.textMediumLarge.orange5,
                          ),
                          const Gap(10),
                          Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colours.lightThemeGrey2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                color: Colours.lightThemeOrange5,
                                onPressed: increment,
                                iconSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colours.lightThemeGrey2,
                thickness: 0.5,
                endIndent: 5,
                indent: 5,
              ),
              for (var supp in activeSupplements)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${supp.name} x${supp.quantity}",
                      style: TextStyles.textMediumSmall.black1,
                    ),
                    Text(
                      "${supp.price * supp.quantity!} CFA",
                      style: TextStyles.textMediumSmall.red5,
                    ),
                  ],
                ),
              const Gap(20),
            ],
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: GestureDetector(
            onTap: removeProductFromCart,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colours.lightThemeGrey0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}