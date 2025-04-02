import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/pages/profile/profile_settings/sections/order_card/order_card_widgets.dart';
import 'package:testing/pages/profile/profile_settings/sections/profile_picture/profile_picture_widgets.dart';
import 'package:testing/pages/profile/profile_settings/sections/settings_list_view/settings_list_widgets.dart';

Widget profileSettingsform(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Gap(80),
        profileAvatar("asma", "asma@gmail.com"),
        Gap(50),
        ordersContainer(context),
        Gap(20),
        builtListView(context),
      ],
    ),
  );
}
