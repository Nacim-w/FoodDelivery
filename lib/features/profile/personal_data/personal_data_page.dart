import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/features/profile/personal_data/widgets/personal_data_form_widget.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart';

class PersonalDataPage extends StatefulWidget {
  static const routePath = 'personalDataPage';

  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      context.adaptiveGap,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ProfileSettingsAppbar(title: 'Paramètres du profil'),
      ),
      Gap(20),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: PersonalDataForm(),
        ),
      ),
    ]);
  }
}
