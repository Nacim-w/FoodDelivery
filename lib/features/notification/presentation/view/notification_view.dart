import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/features/notification/presentation/adapter/notification_cubit.dart';
import 'package:legy/features/notification/presentation/adapter/notification_state.dart';
import 'package:legy/features/notification/presentation/widgets/notification_appbar.dart';
import 'package:legy/features/notification/presentation/widgets/notification_item.dart';

class NotificationView extends StatefulWidget {
  static const routePath = 'notification';

  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          context.adaptiveGap,
          const NotificationAppbar(),
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state.isLoadingNotifications) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.notificationsError != null) {
                  return Center(
                    child: Text(
                      state.notificationsError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final notifications = state.notifications;

                if (notifications == null || notifications.isEmpty) {
                  return const Center(
                    child: Text("Aucune notification disponible."),
                  );
                }

                // Show list of notifications
                return ListView.separated(
                  padding: const EdgeInsets.only(top: 35),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const Gap(20),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationItem(
                      notification: notification,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
