import 'package:flutter/material.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/Auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/home/home_page.dart';
import 'package:testing/pages/Auth/sign_in/widgets/sign_in_widgets.dart';
import 'package:testing/common/res/styles/colours.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAutoSizeText(
                'Connectez-vous à votre compte',
              ),
              buildSlogan(
                "Veuillez vous connecter à votre compte",
              ),
              SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                    "Adresse e-mail",
                  ),
                  SizedBox(height: 5),
                  buildTextField(
                    "Ecivez votre adresse e-mail",
                    "email",
                  ),
                  SizedBox(height: 20),
                  reusableText("Mot de passe"),
                  SizedBox(height: 5),
                  buildTextField(
                    "Ecivez votre mot de passe",
                    "password",
                  ),
                  SizedBox(height: 20),
                  forgotPassword(context),
                  buildLogInAndRegButton(
                    context,
                    "Se connecter",
                    "login",
                    () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  buildSeperater(context),
                  buildThirdPartyLogin(
                    context,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      reusableText(
                        "Vous n'avez pas de compte ? ",
                      ),
                      goToRegister(
                        () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.register,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
