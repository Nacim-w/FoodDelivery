import 'package:flutter/material.dart';
import 'package:legy/features/auth/presentation/widgets/sign_up/register_form_widget.dart';

class SignUpPage extends StatefulWidget {
  static const routePath = '/signUpPage';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  void handleCheckboxChange(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: RegisterForm()),
    );
  }
}
