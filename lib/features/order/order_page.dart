import 'package:flutter/material.dart';
import 'package:legy/features/order/full_cart/full_cart_widget.dart';

class CartPage extends StatefulWidget {
  static const routePath = '/orders';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return FullCart();
  }
}
