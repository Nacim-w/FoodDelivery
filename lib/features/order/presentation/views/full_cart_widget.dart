import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/features/order/presentation/widgets/command_section/order_widget.dart';
import 'package:legy/features/order/presentation/widgets/details_section/details_widget.dart';
import 'package:legy/features/order/presentation/widgets/payment_section/payment_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';

class FullCart extends StatefulWidget {
  static const routePath = 'fullCart';

  const FullCart({super.key});

  @override
  State<FullCart> createState() => _FullCartWidgetState();
}

class _FullCartWidgetState extends State<FullCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(40),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ProfileSettingsAppbar(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Command(),
                DetailsWidget(),
                PaymentWidget(),
                Gap(20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
