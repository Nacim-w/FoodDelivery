import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/pages/Auth/forgot_password/widgets/forgot_password_widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colours.lightThemePrimaryColor,
        appBar: AppBar(
          backgroundColor: Colours.lightThemePrimaryColor,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: forgotPasswordForm(context),
        ),
      ),
    );
  }
}
