import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/Auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/Auth/register/widgets/register_widget.dart';
import 'package:testing/common/res/styles/colours.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAutoSizeText(
                'Créez votre nouveau compte',
              ),
              buildSlogan(
                "Créez un compte pour commencer à chercher les plats que vous aimez.",
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                    "Adresse e-mail",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  buildTextField(
                    "Ecivez votre adresse e-mail",
                    "email",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  reusableText("Nom d'utilisateur"),
                  SizedBox(
                    height: 5,
                  ),
                  buildTextField(
                    "Ecivez votre nom d'utilisateur",
                    "email",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  reusableText("Mot de passe"),
                  SizedBox(
                    height: 5,
                  ),
                  buildTextField(
                    "Ecivez votre mot de passe",
                    "password",
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(
                          color: Colours.lightThemePrimaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5.0,
                          ),
                        ),
                        fillColor: WidgetStateProperty.all(
                            Colours.lightThemeOrangeTextColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(
                            () {
                              isChecked = value!;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: 280,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Wrap(
                            children: [
                              AutoSizeText(
                                "J'accepte ",
                                style: TextStyles.textMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              goToLegal(
                                () => {},
                                "Les Conditions d'Utilisation",
                                "con",
                              ),
                              Text(
                                " et ",
                                style: TextStyles.textMedium,
                              ),
                              goToLegal(
                                () => {},
                                "Politique de Confidentialité",
                                "pol",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildLogInAndRegButton(
                      context, "S'inscrire", "register", () {}),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        child: Divider(
                          color: Colours.lightThemeSecondaryTextColor,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: buildSlogan(
                          "Ou connectez-vous avec",
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        child: Divider(
                          color: Colours.lightThemeSecondaryTextColor,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  buildThirdPartyLogin(context),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      reusableText(
                        "Vous n'avez pas de compte ? ",
                      ),
                      goToSignIn(() =>
                          Navigator.of(context).pushNamed(AppRoutes.register)),
                    ],
                  ),
                  SizedBox(
                    height: 40,
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
