import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/core_utils.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/auth/presentation/views/forgot_password_view.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_seperator_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/thirdparty_login_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_in/complete_profile_view.dart';
import 'package:legy/features/auth/presentation/widgets/sign_in/suggest_register_widget.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';
import 'package:legy/features/preferences/presentation/view/preferences_view.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthError) {
          showToast(message: state.message, success: false);
        }
        if (state is AuthMissingPhoneNumber) {
          context
              .go('${SignInPage.routePath}/${CompleteProfileView.routePath}');
          return;
        }

        if (state is LoggedIn || state is LoggedInGoogle) {
          try {
            final token = sl<CacheHelper>().getSessionToken();

            if (token != null) {
              final profile = await sl<AuthService>().getClientProfile(token);
              final isProfileIncomplete = profile.phoneNumber.trim().isEmpty ||
                  profile.address.trim().isEmpty;

              if (isProfileIncomplete) {
                context.go(
                    '${SignInPage.routePath}/${CompleteProfileView.routePath}');
              } else {
                final isFirstTime = sl<CacheHelper>().isFirstTime();
                if (isFirstTime) {
                  context
                      .go('${HomePage.routePath}/${PreferencesView.routePath}');
                } else {
                  context.go(HomePage.routePath);
                }
              }
            } else {
              showToast(message: "Jeton invalide.", success: false);
            }
          } catch (e) {
            showToast(
                message: 'Erreur lors de la récupération du profil',
                success: false);
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.adaptiveGap,
              Text('Connectez-vous à votre compte',
                  style: TextStyles.titleBoldLarge.orange5),
              Gap(10),
              Text(
                "Veuillez vous connecter à votre compte",
                style: TextStyles.textMedium.grey1,
              ),
              const Gap(30),
              VerticalLabelField(
                defaultValidation: false,
                label: "Adresse e-mail",
                hintText: "Écrivez votre adresse e-mail",
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Veuillez entrer votre adresse e-mail";
                  }

                  final emailRegex =
                      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                  if (!emailRegex.hasMatch(val)) {
                    return "Veuillez entrer une adresse e-mail valide";
                  }

                  return null;
                },
              ),
              const Gap(20),
              VerticalLabelField(
                label: 'Mot de passe',
                suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(isPasswordVisible
                        ? IconlyLight.hide
                        : IconlyLight.show)),
                controller: _passwordController,
                hintText: 'Écrivez votre mot de passe',
                keyboardType: TextInputType.text,
                obscureText: isPasswordVisible,
                defaultValidation: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre mot de passe";
                  }
                  return null;
                },
              ),
              const Gap(20),
              _forgotPassword(context),
              RoundedButton(
                backgroundColour: Colours.lightThemeOrange5,
                text: "Se connecter",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    context.read<AuthCubit>().login(email, password);
                  }
                },
              ).loading(state is AuthLoading),
              const Gap(10),
              RoundedButton(
                backgroundColour: Colours.lightThemeGrey0.withAlpha(100),
                text: "Continuer en tant qu’invité ",
                onPressed: () => context.go(HomePage.routePath),
              ),
              const Gap(20),
              const BuildSeperater(),
              const BuildThirdPartyLogin(),
              const Gap(20),
              const SuggestRegister(),
            ],
          ),
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return SizedBox(
      width: context.width * 0.9,
      height: 44,
      child: GestureDetector(
        onTap: () => context
            .push('${SignInPage.routePath}/${ForgotPasswordView.routePath}'),
        child: Text(
          "Mot de passe oublié?",
          textAlign: TextAlign.right,
          style: TextStyles.textMedium.orange5,
        ),
      ),
    );
  }
}
