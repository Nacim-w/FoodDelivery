import 'package:flutter/material.dart';

import 'package:legy/features/auth/presentation/widgets/sign_in/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  static const routePath = '/signUpPage';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: const SignInForm(),
      ),
    );
  }
}
