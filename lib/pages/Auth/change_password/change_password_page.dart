import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/Auth/change_password/widgets/change_password_widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.lightThemePrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Réinitialiser le mot de passe',
            style: TextStyles.textSemiBold),
        backgroundColor: Colours.lightThemePrimaryColor,
      ),
      body: changePasswordForm(context),
    );
  }
}
