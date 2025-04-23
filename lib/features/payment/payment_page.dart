import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

import 'package:legy/features/payment/payment_form.dart';

class PaymentPage extends StatefulWidget {
  static const routePath = 'payment';

  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
      body: PaymentForm(),
    );
  }
}
