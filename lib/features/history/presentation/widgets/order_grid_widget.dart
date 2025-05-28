import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/history/presentation/widgets/grid_order_item_widget.dart';

class OrderGrid extends StatefulWidget {
  const OrderGrid({super.key});

  @override
  State<OrderGrid> createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        Gap(15),
        SizedBox(
          height: context.height * 0.4,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: List.generate(
              10,
              (index) => GridOrderItem(
                pic: Media.order1,
                name: "Pizza au fromage",
                details: "Two Spoons - Mangalore",
                price: "6 CFA",
              ),
            ),
          ),
        )
      ],
    );
  }
}
