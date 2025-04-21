import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/features/profile/profile_settings/sections/order_card/order_card_widgets.dart';
import 'package:legy/features/profile/profile_settings/sections/profile_picture/profile_picture_widgets.dart';
import 'package:legy/features/profile/profile_settings/sections/settings_list_view/settings_list_widgets.dart';

class ProfileSettingsForm extends StatelessWidget {
  const ProfileSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(80),
          ProfileAvatar(name: "asma", email: "asma@gmail.com"),
          Gap(50),
          OrdersContainer(),
          Divider(
            color: Colors.grey.withAlpha(50),
            thickness: 0.5,
            endIndent: 25,
            indent: 25,
          ),
          BuiltListView(),
        ],
      ),
    );
  }
}
