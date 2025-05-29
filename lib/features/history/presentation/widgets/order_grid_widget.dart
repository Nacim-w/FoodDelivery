import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/history/model/history_order_models.dart';
import 'package:legy/features/history/presentation/widgets/grid_order_item_widget.dart';

class OrderGrid extends StatefulWidget {
  final List<OrderModel> orders;

  const OrderGrid({super.key, required this.orders});

  @override
  State<OrderGrid> createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: widget.orders.map((order) {
          return GridOrderItem(
            pic: Media.restaurant1, // replace with real image if available
            name: order.items.isNotEmpty
                ? order.items[0].productName
                : 'Commande',
            details: order.restaurant.name,
            price: '${order.total.toStringAsFixed(2)} CFA',
          );
        }).toList(),
      ),
    );
  }
}
