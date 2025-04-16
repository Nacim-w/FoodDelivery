import 'package:flutter/material.dart';
import 'package:legy/pages/profile/profile_settings/widgets/profile_settings_widgets.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ProfileSettingsForm();
  }
}
