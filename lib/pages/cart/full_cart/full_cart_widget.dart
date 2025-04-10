import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:testing/pages/cart/full_cart/sections/command_section/order_widget.dart';
import 'package:testing/pages/cart/full_cart/sections/details_section/details_widget.dart';
import 'package:testing/pages/cart/full_cart/sections/payment_section/payment_widget.dart';

class FullCart extends StatefulWidget {
  const FullCart({super.key});

  @override
  State<FullCart> createState() => _FullCartWidgetState();
}

class _FullCartWidgetState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(20),
          Command(),
          DetailsWidget(),
          PaymentWidget(),
          Gap(20),
        ],
      ),
    );
  }
}
