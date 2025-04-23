import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

import 'package:legy/features/profile/profile_settings/widgets/profile_settings_widgets.dart';

class ProfileSettingsPage extends StatefulWidget {
  static const routePath = '/profile';

  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettingsPage> {
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
      body: const ProfileSettingsForm(),
    );
  }
}
