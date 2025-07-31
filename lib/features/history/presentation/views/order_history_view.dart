import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/common/widgets/black_app_bar.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';
import 'package:legy/features/history/presentation/app/history_cubit.dart';
import 'package:legy/features/history/presentation/app/history_state.dart';
import 'package:legy/features/history/presentation/widgets/current_order_widget.dart';
import 'package:legy/features/history/presentation/widgets/order_card.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/web_socket/presentation/presentation/order_tracking_view.dart';

enum OrderFilter { tous, suivi, ancien }

class OrderHistoryView extends StatefulWidget {
  static const routePath = '/orders';

  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  OrderFilter _selectedFilter = OrderFilter.tous;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();

    final token = sl<CacheHelper>().getSessionToken();

    if (token == null || token.isEmpty) {
      // No token = guest → show login prompt directly
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoginDialog();
      });
    } else {
      context.read<HistoryCubit>().loadOrders();
    }
  }

  void _showLoginDialog() {
    if (_dialogShown) return;
    _dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colours.lightThemeWhite1,
        title: Text(
          'Session expirée',
          style: TextStyles.titleBold.black1,
        ),
        content: Text(
          'Veuillez vous connecter ou créer un compte pour continuer.',
          style: TextStyles.textMediumLarge.black1,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go(HomePage.routePath);
                },
                child: Text('Retour', style: TextStyles.textMedium.black1),
              ),
              const SizedBox(width: 16), // space between buttons

              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go(SignInPage.routePath);
                },
                child:
                    Text('Se connecter', style: TextStyles.textMedium.orange5),
              ),
            ],
          ),
        ],
      ),
    ).then((_) => _dialogShown = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HistoryCubit, HistoryState>(
          listener: (context, state) {
            if (state is HistorySessionExpired) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showLoginDialog();
              });
            }
          },
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoaded) {
              final allOrders = state.orders;
              final pendingOrder = allOrders
                      .where((order) => order.orderStatus == 'PENDING')
                      .cast<dynamic>()
                      .isNotEmpty
                  ? allOrders
                      .firstWhere((order) => order.orderStatus == 'PENDING')
                  : null;
              final historyOrders = allOrders
                  .where((order) => order.orderStatus != 'PENDING')
                  .toList();

              final showCurrent = _selectedFilter == OrderFilter.tous ||
                  _selectedFilter == OrderFilter.suivi;
              final showHistory = _selectedFilter == OrderFilter.tous ||
                  _selectedFilter == OrderFilter.ancien;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.adaptiveGap,
                    BlackAppBar(
                      color: Colours.lightThemeGreen5,
                      title: 'Historique des commandes',
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(HomePage.routePath);
                        }
                      },
                    ),
                    const Gap(30),
                    Text(
                      'Commandes récentes',
                      style: TextStyles.textBold.green5,
                    ),
                    const Gap(20),
                    _buildFilterButtons(),
                    const Gap(20),
                    if (showCurrent) ...[
                      Text("Livraison en cours", style: TextStyles.textBold),
                      const Gap(20),
                      if (pendingOrder != null)
                        GestureDetector(
                            onTap: () => {
                                  context.go(
                                      '${HomePage.routePath}/${OrderTrackingView.routePath}?orderId=${pendingOrder.orderId}'),
                                },
                            child: CurrentOrderWidget(order: pendingOrder)),
                      const Gap(20),
                    ],
                    if (showHistory && historyOrders.isNotEmpty) ...[
                      Text("Commandes récentes",
                          style: TextStyles.textSemiBold.black1),
                      const Gap(10),
                      ...historyOrders.map((order) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () async {
                              context.go(
                                  '${HomePage.routePath}/${OrderTrackingView.routePath}?orderId=${order.orderId}');
                            },
                            child: OrderCard(order: order),
                          ),
                        );
                      }),
                    ],
                    if (!showCurrent && !showHistory)
                      const Center(child: Text("Aucune commande à afficher.")),
                  ],
                ),
              );
            } else if (state is HistoryError) {
              return Center(child: Text('Erreur: ${state.message}'));
            }

            // By default, show nothing or maybe a placeholder
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterButton("Tous", OrderFilter.tous),
        _buildFilterButton("Suivi", OrderFilter.suivi),
        _buildFilterButton("Ancien", OrderFilter.ancien),
      ],
    );
  }

  Widget _buildFilterButton(String label, OrderFilter filter) {
    final isSelected = _selectedFilter == filter;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colours.lightThemeGreen5 : Colours.lightThemeWhite1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colours.lightThemeGreen5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colours.lightThemeWhite1
                : Colours.lightThemeGreen5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
