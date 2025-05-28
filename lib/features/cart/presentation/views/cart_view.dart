import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/cart/presentation/views/full_cart_view.dart';

class CartPage extends StatefulWidget {
  static const routePath = '/orders';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
      body: FullCartView(),
    );
  }
}
