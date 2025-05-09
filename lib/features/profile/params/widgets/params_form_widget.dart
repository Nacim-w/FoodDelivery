import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/params/widgets/build_list_tile_widget.dart';
import 'package:legy/features/profile/params/widgets/build_switch_tile_widget.dart';
import 'package:legy/features/profile/params/widgets/param_appbar.dart';

class ParamsForm extends StatefulWidget {
  const ParamsForm({super.key});

  @override
  State<ParamsForm> createState() => _ParamsFormState();
}

class _ParamsFormState extends State<ParamsForm> {
  bool isPushNotificationEnabled = false;
  bool isLocationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ParamAppbar(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSectionTitle("PROFIL"),
                BuildSwitchTile(
                  title: "Notification push",
                  value: isPushNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isPushNotificationEnabled = value;
                    });
                  },
                ),
                BuildSwitchTile(
                  title: "Localisation",
                  value: isLocationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isLocationEnabled = value;
                    });
                  },
                ),
                BuildListTile(title: "Langue", subtitle: "Français"),
                const SizedBox(height: 16),
                _buildSectionTitle("AUTRE"),
                BuildListTile(title: "À propos de Tickets"),
                BuildListTile(title: "Politique de confidentialité"),
                BuildListTile(title: "Conditions générales"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title,
        style: TextStyles.textSemiBold.black1,
      ),
    );
  }
}
