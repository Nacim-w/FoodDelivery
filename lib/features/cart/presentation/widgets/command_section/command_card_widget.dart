import 'dart:convert';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:legy/core/common/app/cache_helper.dart';

class CommandCardWidget extends StatefulWidget {
  final ProductModel product;
  final List<Supplement> supplements;
  final VoidCallback? onRemoved;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CommandCardWidget({
    super.key,
    required this.product,
    required this.supplements,
    this.onRemoved,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<CommandCardWidget> createState() => _CommandCardWidgetState();
}

class _CommandCardWidgetState extends State<CommandCardWidget> {
  late Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
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
    imageBytes = base64Decode(widget.product.imageUrl.split(',').last);
  }

  Future<void> removeProductFromCart(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);

    final currentProducts = cacheHelper.getCartProducts();
    currentProducts.removeWhere((p) => p.id == widget.product.id);
    await cacheHelper.cacheCartProducts(currentProducts);

    if (widget.onRemoved != null) {
      widget.onRemoved!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> supplementMap = {};

    for (var supp in widget.supplements) {
      if (supp.quantity != null && supp.quantity! > 0) {
        if (supplementMap.containsKey(supp.name)) {
          supplementMap[supp.name]!['quantity'] += supp.quantity!;
        } else {
          supplementMap[supp.name] = {
            'quantity': supp.quantity!,
            'price': supp.price,
          };
        }
      }
    }

    final double productTotal =
        widget.product.pricePostCom * widget.product.quantity;

    return Stack(
      children: [
        DottedBorder(
          color: Colours.lightThemeOrange5,
          dashPattern: const [6, 6],
          strokeWidth: 1.5,
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
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
                Gap(15),
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
                        Text(widget.product.name,
                            style: TextStyles.textMediumSmall.black1),
                        const Gap(10),
                        Text('${productTotal.toInt()} CFA',
                            style: TextStyles.textMediumLarge.orange5),
                        const Gap(10),
                        Row(
                          children: [
                            Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colours.lightThemeOrange5,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colours.lightThemeBlack0
                                          .withAlpha(50),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  color: Colours.lightThemeWhite1,
                                  onPressed: widget.onDecrement,
                                  iconSize: 12,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 24, // enough for 2-3 digits
                              child: Text(
                                widget.product.quantity.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyles.textMediumLarge.orange5,
                              ),
                            ),
                            const Gap(10),
                            Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colours.lightThemeOrange0,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colours.lightThemeBlack0
                                          .withAlpha(50),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colours.lightThemeWhite1,
                                  onPressed: widget.onIncrement,
                                  iconSize: 12,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(10),
                Divider(
                  color: Colours.lightThemeGrey2,
                  thickness: 0.5,
                  endIndent: 5,
                  indent: 5,
                ),
                Gap(10),
                for (var entry in supplementMap.entries)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${entry.key} x${entry.value['quantity']}",
                          style: TextStyles.textMediumSmall.black1),
                      Text(
                          "${entry.value['price'] * entry.value['quantity']} CFA",
                          style: TextStyles.textMedium.orange5),
                    ],
                  ),
                const Gap(20),
              ],
            ),
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: GestureDetector(
            onTap: () => removeProductFromCart(context),
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colours.lightThemeGrey0,
            ),
          ),
        ),
      ],
    );
  }
}
