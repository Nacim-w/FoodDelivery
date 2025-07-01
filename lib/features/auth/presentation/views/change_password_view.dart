import 'package:flutter/material.dart';
import 'package:legy/features/auth/presentation/widgets/change_password/change_pass_form_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routePath = 'changePasswordPage';

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangePasswordForm(),
    );
  }
}
