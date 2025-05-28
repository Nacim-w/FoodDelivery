import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/history/presentation/widgets/current_order_widget.dart';
import 'package:legy/features/history/presentation/widgets/order_grid_widget.dart';

class OrderHistoryView extends StatefulWidget {
  static const routePath = '/orders';

  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
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
        title: Text(
          'Historique des commandes',
          style: TextStyles.textMediumLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Livraison en cours",
                style: TextStyles.textSemiBold,
              ),
              Gap(20),
              CurrentOrderWidget(),
              Gap(20),
              Text(
                "Commandes récentes",
                style: TextStyles.textSemiBold,
              ),
              OrderGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
