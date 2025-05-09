import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/features/notification/presentation/widgets/custom_toggle_switch.dart';
import 'package:legy/features/notification/presentation/widgets/notification_appbar.dart';
import 'package:legy/features/notification/presentation/widgets/notification_item.dart';

class NotificationView extends StatefulWidget {
  static const routePath = 'notification';

  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int selectedIndex = 0;

  get width => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Gap(35),
          NotificationAppbar(),
          Gap(20),
          CustomToggleSwitch(),
          const Gap(30),
          if (selectedIndex == 0) ...[
            const NotificationItem(),
            const Gap(20),
            const NotificationItem(),
          ] else ...[
            const NotificationItem(),
            const Gap(20),
            const NotificationItem(),
            const Gap(20),
            const NotificationItem(),
          ],
        ],
      ),
    );
  }
}
