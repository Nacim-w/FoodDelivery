import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

import 'package:legy/features/order/full_cart/sections/command_section/order_widget.dart';
import 'package:legy/features/order/full_cart/sections/details_section/details_widget.dart';
import 'package:legy/features/order/full_cart/sections/payment_section/payment_widget.dart';

class FullCart extends StatefulWidget {
  static const routePath = 'fullCart';

  const FullCart({super.key});

  @override
  State<FullCart> createState() => _FullCartWidgetState();
}

class _FullCartWidgetState extends State<FullCart> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            Command(),
            DetailsWidget(),
            PaymentWidget(),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
