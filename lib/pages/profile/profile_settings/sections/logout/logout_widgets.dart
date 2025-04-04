import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/profile/profile_settings/sections/logout/build_backdrop_filter_widget.dart';

class Outbutton extends StatelessWidget {
  const Outbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return BuildBackdropFilter();
            },
          );
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          side: BorderSide(color: Colours.lightThemeBorderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: Icon(Icons.logout, color: Colours.lightThemeOrangeTextColor),
        label: Text("Se déconnecter", style: TextStyles.textSemiBold.orange),
      ),
    );
  }
}
