import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

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
          buildSectionTitle("PROFIL"),
          buildSwitchTile("Notification push", isPushNotificationEnabled,
              (value) {
            setState(() {
              isPushNotificationEnabled = value;
            });
          }),
          buildSwitchTile("Localisation", isLocationEnabled, (value) {
            setState(() {
              isLocationEnabled = value;
            });
          }),
          buildListTile("Langue", "Français"),
          SizedBox(height: 16),
          buildSectionTitle("AUTRE"),
          buildListTile("À propos de Tickets"),
          buildListTile("Politique de confidentialité"),
          buildListTile("Conditions générales"),
        ],
      ),
    );
  }
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyles.textSemiBold.black,
    ),
  );
}

Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
  return SwitchListTile(
    title: Text(title, style: TextStyles.textMedium),
    value: value,
    onChanged: onChanged,
    inactiveThumbColor: Colors.white,
    inactiveTrackColor: Color(0xFFDFE0F3),
    activeColor: Colours.lightThemeOrangeTextColor,
  );
}

Widget buildListTile(String title, [String? subtitle]) {
  return ListTile(
    title: Text(title, style: TextStyles.textMedium),
    trailing: subtitle != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(subtitle, style: TextStyles.textMedium),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
            ],
          )
        : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
    onTap: () {},
  );
}
