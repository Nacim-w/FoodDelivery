import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/order/order_history/sections/current_order/current_order_widget.dart';
import 'package:legy/features/order/order_history/sections/order_grid/order_grid_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  static const routePath = '/orders';

  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go(HomePage.routePath);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CurrentOrderWidget(),
              OrderGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
