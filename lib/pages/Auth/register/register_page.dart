import 'package:flutter/material.dart';
import 'package:testing/pages/Auth/register/widgets/register_widgets.dart';
import 'package:testing/common/res/styles/colours.dart';

class SignUpPage extends StatefulWidget {
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
          child: registerForm(context, isChecked, handleCheckboxChange),
        ),
      ),
    );
  }
}
