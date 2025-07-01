import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/order_details/presentation/app/adapter/order_details_cubit.dart';
import 'package:legy/features/order_details/presentation/app/adapter/order_details_state.dart';
import 'package:legy/features/order_details/service/order_details_service.dart';
import 'package:legy/features/order_details/model/details_items_model.dart';

class OrderDetailsView extends StatelessWidget {
  static const routePath = 'order-details';

  final String orderId;

  const OrderDetailsView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails de la commande")),
      body: BlocProvider(
        create: (context) =>
            OrderDetailsCubit(orderDetailsService: OrderDetailsService())
              ..loadOrder(orderId),
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderDetailsLoaded) {
              final order = state.order;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text("ID: ${order.id}",
                        style: const TextStyle(fontSize: 18)),
                    const Gap(8),
                    Text("Total: ${order.total.toStringAsFixed(2)} CFA",
                        style: const TextStyle(fontSize: 18)),
                    const Gap(16),
                    Text("Restaurant: ${order.restaurant.name}"),
                    Text(
                        "Client: ${order.client.firstName} ${order.client.lastName}"),
                    const Gap(16),
                    ...order.items
                        .map((item) => _buildOrderItem(context, item)),
                  ],
                ),
              );
            } else if (state is OrderDetailsError) {
              return Center(child: Text("Erreur : ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, DetailsOrderItem item) {
    double totalSupplements = item.supplements.fold(0.0, (sum, supp) {
      final qty = supp.quantity ?? 0;
      return sum;
    });
    final total = item.unitPrice * item.quantity + totalSupplements;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colours.lightThemeWhite1,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colours.lightThemeGrey2.withAlpha(127),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.productName, style: TextStyles.textMediumSmall.black1),
          const Gap(8),
          Text('${total.toStringAsFixed(2)} CFA',
              style: TextStyles.textMediumLarge.red5),
          const Gap(8),
          Row(
            children: [
              Text('Quantité: ${item.quantity}',
                  style: TextStyles.textMediumSmall.black1),
              const SizedBox(width: 16),
              Text('Prix unitaire: ${item.unitPrice.toStringAsFixed(2)}',
                  style: TextStyles.textMediumSmall.black1),
            ],
          ),
          const Gap(10),
          for (var supp in item.supplements)
            if ((supp.quantity ?? 0) > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("supp1 x${supp.quantity}",
                      style: TextStyles.textMediumSmall.black1),
                ],
              ),
        ],
      ),
    );
  }
}
