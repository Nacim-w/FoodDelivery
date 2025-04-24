import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/profile/profile_settings/sections/logout/build_backdrop_filter_widget.dart';

class Outbutton extends StatelessWidget {
  const Outbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
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
          side: BorderSide(color: Colours.lightThemeGrey2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: Icon(Icons.logout, color: Colours.lightThemeOrange5),
        label: Text("Se déconnecter", style: TextStyles.textSemiBold.orange5),
      ),
    );
  }
}
