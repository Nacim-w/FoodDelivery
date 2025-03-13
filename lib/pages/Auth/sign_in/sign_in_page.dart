import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/common/routes/names.dart';
import 'package:testing/common/widgets/base_text_widget.dart';
import 'package:testing/common/widgets/common_widgets.dart';
import 'package:testing/pages/home/home_page.dart';
import 'package:testing/pages/Auth/sign_in/widgets/sign_in_widgets.dart';
import 'package:testing/pages/Auth/register/sign_up_page.dart';

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
                'Connectez-vous à votre compte',
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              buildSlogan(
                "Veuillez vous connecter à votre compte",
              ),
              SizedBox(height: 40.h),
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
                  reusableText("Mot de passe"),
                  SizedBox(
                    height: 5.h,
                  ),
                  buildTextField(
                    "Ecivez votre mot de passe",
                    "password",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  forgotPassword(),
                  buildLogInAndRegButton("Se connecter", "login", () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }),
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
                      goToText(() {
                        Navigator.of(context).pushNamed(AppRoutes.REGISTER);
                      }),
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
