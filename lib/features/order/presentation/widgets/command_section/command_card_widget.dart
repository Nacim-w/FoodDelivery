import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/product/model/product_model.dart';

class CommandCardWidget extends StatefulWidget {
  final ProductModel product;
  final List<Supplement> supplements;

  const CommandCardWidget({
    super.key,
    required this.product,
    required this.supplements,
  });

  @override
  State<CommandCardWidget> createState() => _CommandCardWidgetState();
}

class _CommandCardWidgetState extends State<CommandCardWidget> {
  late int productQuantity;

  @override
  void initState() {
    super.initState();
    productQuantity = widget.product.quantity; // Initialize quantity
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

  @override
  Widget build(BuildContext context) {
    final base64Str = widget.product.imageUrl.split(',').last;
    Uint8List imageBytes = base64Decode(base64Str);

    // Filter supplements to only show those with quantity > 0
    final activeSupplements = widget.supplements
        .where((supplement) =>
            supplement.quantity != null && supplement.quantity! > 0)
        .toList();

    // Calculate product total price
    double productTotal = productQuantity * widget.product.pricePostCom;

    return Container(
      padding: EdgeInsets.all(10),
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
          // Product Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(10),
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
              Gap(30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyles.textMediumSmall.black1,
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Text(
                        '${widget.product.pricePostCom} CFA ',
                        style: TextStyles.textMediumLarge.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Colours.lightThemeGrey1,
                        ),
                      ),
                      Text(
                        '$productTotal CFA', // Adjusted product price based on quantity
                        style: TextStyles.textMediumLarge.red5,
                      ),
                    ],
                  ),
                  Gap(10),
                  // Quantity Controls for Product
                  Row(
                    children: [
                      Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colours.lightThemeGrey2),
                              shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(Icons.remove),
                            color: Colours.lightThemeOrange5,
                            onPressed: decrement,
                            iconSize: 12,
                          ),
                        ),
                      ),
                      Gap(10),
                      Text(productQuantity.toString(),
                          style: TextStyles.textMediumLarge.orange5),
                      Gap(10),
                      Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colours.lightThemeGrey2),
                              shape: BoxShape.circle),
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

          // Supplements with Quantity > 0
          for (var supp in activeSupplements)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${supp.name} x${supp.quantity}",
                    style: TextStyles.textMediumSmall
                        .black1), // Show supplement name and quantity
                Text("${supp.price * supp.quantity!} CFA",
                    style: TextStyles.textMediumSmall.red5),
              ],
            ),
          Gap(20),
        ],
      ),
    );
  }
}
