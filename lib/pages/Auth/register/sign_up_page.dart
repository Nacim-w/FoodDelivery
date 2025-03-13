import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/base_text_widget.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/Auth/register/widgets/sign_up_widget.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                'Créez votre nouveau compte',
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              buildSlogan(
                "Créez un compte pour commencer à chercher les plats que vous aimez.",
              ),
              SizedBox(height: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                    "Adresse e-mail",
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildTextField(
                    "Ecivez votre adresse e-mail",
                    "email",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  reusableText("Nom d'utilisateur"),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildTextField(
                    "Ecivez votre nom d'utilisateur",
                    "email",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  reusableText("Mot de passe"),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildTextField(
                    "Ecivez votre mot de passe",
                    "password",
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        fillColor: WidgetStateProperty.all(Color(0xFFFF7300)),
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
                        width: 280.w,
                        child: Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: Wrap(
                            children: [
                              AutoSizeText(
                                "J'accepte ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
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
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              goToLegal(() => {},
                                  "Politique de Confidentialité", "pol"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  buildLogInAndRegButton("S'inscrire", "register", () {}),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        child: Divider(
                          color: Color(0xFF878787),
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: buildSlogan("Ou connectez-vous avec"),
                      ),
                      SizedBox(
                        width: 64,
                        child: Divider(
                          color: Color(0xFF878787),
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  buildThirdPartyLogin(context),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      reusableText("Vous n'avez pas de compte ? "),
                      goToText(() =>
                          Navigator.of(context).pushNamed(AppRoutes.REGISTER)),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
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
