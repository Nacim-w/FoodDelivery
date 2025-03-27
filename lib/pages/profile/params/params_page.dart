import 'package:flutter/material.dart';
import 'package:testing/pages/profile/params/widgets/params_widgets.dart';

class Params extends StatefulWidget {
  const Params({super.key});

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> {
  bool isPushNotificationEnabled = false;
  bool isLocationEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white,
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
