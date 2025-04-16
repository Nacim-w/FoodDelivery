import 'package:flutter/material.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/styles/text.dart';
import 'package:legy/pages/profile/params/widgets/build_list_tile_widget.dart';
import 'package:legy/pages/profile/params/widgets/build_switch_tile_widget.dart';

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
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
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
          SizedBox(height: 16),
          _buildSectionTitle("AUTRE"),
          BuildListTile(title: "À propos de Tickets"),
          BuildListTile(title: "Politique de confidentialité"),
          BuildListTile(title: "Conditions générales"),
        ],
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyles.textSemiBold.black1,
    ),
  );
}
