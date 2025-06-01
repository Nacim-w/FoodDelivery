import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/utils/core_utils.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/auth/presentation/views/forgot_password_view.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_seperator_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/thirdparty_login_widget.dart';
import 'package:legy/features/auth/presentation/widgets/sign_in/suggest_register_widget.dart';
import 'package:legy/features/home/presentation/views/home_page.dart';

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
      listener: (context, state) {
        if (state case AuthError(:final message)) {
          showToast(message: message, success: false);
        }
        if (state is LoggedIn) {
          context.go(HomePage.routePath);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.adaptiveGap,
              buildAutoSizeText('Connectez-vous à votre compte.'),
              Text(
                "Veuillez vous connecter à votre compte",
                style: TextStyles.textMedium.grey1,
              ),
              const Gap(40),
              VerticalLabelField(
                label: 'Adresse e-mail',
                controller: _emailController,
                hintText: "Écrivez votre adresse e-mail",
                keyboardType: TextInputType.emailAddress,
                defaultValidation: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre adresse e-mail";
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
