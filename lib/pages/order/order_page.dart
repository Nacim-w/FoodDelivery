import 'package:flutter/material.dart';
import 'package:legy/pages/order/empty_cart/empty_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return EmptyCart();
  }
}
