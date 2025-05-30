import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/history/presentation/app/history_cubit.dart';
import 'package:legy/features/history/presentation/app/history_state.dart';
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
  void initState() {
    super.initState();
    context.read<HistoryCubit>().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.adaptiveGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlackAppBar(title: 'Livraison en cours', onTap: context.pop),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HistoryLoaded) {
                final orders = state.orders;
                if (orders.isEmpty) {
                  return const Center(child: Text('Aucune commande trouvée.'));
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Livraison en cours",
                        style: TextStyles.textSemiBold,
                      ),
                      const Gap(20),
                      const CurrentOrderWidget(),
                      const Gap(20),
                      Text(
                        "Commandes récentes",
                        style: TextStyles.textSemiBold,
                      ),
                      OrderGrid(orders: orders), // pass data here!
                    ],
                  ),
                );
              } else if (state is HistoryError) {
                return Center(child: Text('Erreur: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
