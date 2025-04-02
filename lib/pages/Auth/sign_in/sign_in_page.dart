import 'package:flutter/material.dart';
import 'package:testing/pages/auth/sign_in/widgets/sign_in_widgets.dart';
import 'package:testing/common/res/styles/colours.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.lightThemePrimaryColor,
      appBar: AppBar(
        backgroundColor: Colours.lightThemePrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: signInForm(context),
      ),
    );
  }
}
