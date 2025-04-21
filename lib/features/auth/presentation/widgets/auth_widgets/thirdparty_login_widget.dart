import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';

class BuildThirdPartyLogin extends StatelessWidget {
  const BuildThirdPartyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        margin: EdgeInsets.only(top: 20, bottom: 10),
        padding: EdgeInsets.only(left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            reusableIcons(Media.google),
            reusableIcons(Media.facebook),
            reusableIcons(Media.apple),
          ],
        ),
      ),
    );
  }
}
