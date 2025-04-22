import 'package:flutter/material.dart';

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
    return const ProfileSettingsForm();
  }
}
