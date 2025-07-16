import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/res/media.dart';

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
  late ImageProvider imageProvider;

  @override
  void initState() {
    super.initState();
    _resolveImage(widget.product.imageUrl);
  }

  @override
  void didUpdateWidget(covariant CommandCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.product.imageUrl != oldWidget.product.imageUrl) {
      _resolveImage(widget.product.imageUrl);
    }
  }

  void _resolveImage(String image) {
    if (image.isEmpty) {
      imageProvider = const AssetImage(Media.restaurant1);
    } else if (image.startsWith('http')) {
      imageProvider = NetworkImage(image);
    } else if (image.startsWith('data:image')) {
      try {
        final base64Str = image.split(',').last;
        final bytes = base64Decode(base64Str);
        imageProvider = MemoryImage(bytes);
      } catch (_) {
        imageProvider = const AssetImage(Media.restaurant1);
      }
    } else {
      imageProvider = const AssetImage(Media.restaurant1);
    }

    if (mounted) setState(() {});
  }

  Future<void> removeProductFromCart(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheHelper = CacheHelper(prefs);

    final currentProducts = cacheHelper.getCartProducts();
    currentProducts.removeWhere((p) => p.id == widget.product.id);
    await cacheHelper.cacheCartProducts(currentProducts);

    widget.onRemoved?.call();
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
                const Gap(15),
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
                          image: imageProvider,
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
                            _buildCircleIcon(
                              icon: Icons.remove,
                              onPressed: widget.onDecrement,
                              color: Colours.lightThemeOrange5,
                            ),
                            const Gap(10),
                            SizedBox(
                              width: 24,
                              child: Text(
                                widget.product.quantity.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyles.textMediumLarge.orange5,
                              ),
                            ),
                            const Gap(10),
                            _buildCircleIcon(
                              icon: Icons.add,
                              onPressed: widget.onIncrement,
                              color: Colours.lightThemeOrange0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(10),
                Divider(
                  color: Colours.lightThemeGrey2,
                  thickness: 0.5,
                  endIndent: 5,
                  indent: 5,
                ),
                const Gap(10),
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

  Widget _buildCircleIcon({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeBlack0.withAlpha(50),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colours.lightThemeWhite1,
        onPressed: onPressed,
        iconSize: 12,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
