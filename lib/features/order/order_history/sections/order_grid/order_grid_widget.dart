import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order/order_history/sections/order_grid/grid_order_item_widget.dart';

class OrderGrid extends StatefulWidget {
  const OrderGrid({super.key});

  @override
  State<OrderGrid> createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  String selectedFilter = "Tous";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Livraison en cours",
            style: TextStyles.textSemiBold,
          ),
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton("Tous"),
            _buildFilterButton("Completé"),
            _buildFilterButton("Annulé"),
          ],
        ),
        Gap(15),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
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

  Widget _buildFilterButton(String text) {
    final bool isSelected = selectedFilter == text;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedFilter = text;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isSelected ? Colours.lightThemeOrange5 : Colors.transparent,
        side: BorderSide(color: Colours.lightThemeOrange5),
      ),
      child: Text(
        text,
        style: isSelected
            ? TextStyles.textMedium.white1
            : TextStyles.textMedium.orange5,
      ),
    );
  }
}
