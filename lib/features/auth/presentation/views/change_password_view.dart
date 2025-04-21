import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/change_password/change_pass_form_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routePath = '/changePasswordPage';

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Réinitialiser le mot de passe',
            style: TextStyles.textSemiBold),
      ),
      body: ChangePasswordForm(),
    );
  }
}
