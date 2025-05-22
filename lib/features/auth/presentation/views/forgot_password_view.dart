import 'package:flutter/material.dart';
import 'package:legy/features/auth/presentation/widgets/forgot_password/widgets/forgot_pass_form_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  static const routePath = 'ForgotPasswordView';

  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ForgotPasswordForm(),
      ),
    );
  }
}
