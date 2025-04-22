import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/utils/core_utils.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_seperator_widget.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/thirdparty_login_widget.dart';
import 'package:legy/features/auth/presentation/views/forgot_password_view.dart';
import 'package:legy/features/auth/presentation/widgets/sign_in/suggest_register_widget.dart';
import 'package:legy/features/auth/app/auth_cubit.dart';
import 'package:legy/features/auth/app/auth_state.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    context.read<LoginCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showToast(state.error, success: false);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAutoSizeText('Connectez-vous à votre compte.'),
            Text(
              "Veuillez vous connecter à votre compte",
              style: TextStyles.textMedium.grey1,
            ),
            const Gap(40),
            Text("Adresse e-mail", style: TextStyles.textMedium.black2),
            const SizedBox(height: 5),
            BuildTextField(
              controller: _emailController,
              hintText: "Écrivez votre adresse e-mail",
              textType: "email",
            ),
            const Gap(20),
            Text("Mot de passe", style: TextStyles.textMedium.black2),
            const Gap(5),
            BuildTextField(
              controller: _passwordController,
              hintText: "Écrivez votre mot de passe",
              textType: "password",
            ),
            const Gap(20),
            _forgotPassword(context),
            BuildLogInAndRegButton(
              isLoading ? "Chargement..." : "Se connecter",
              "login",
              isLoading ? null : _onLoginPressed,
            ),
            const Gap(20),
            const BuildSeperater(),
            const BuildThirdPartyLogin(),
            const Gap(20),
            const SuggestRegister(),
          ],
        );
      },
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 44,
      child: GestureDetector(
        onTap: () => context.go(ForgotPasswordPage.routePath),
        child: Text(
          "Mot de passe oublié?",
          textAlign: TextAlign.right,
          style: TextStyles.textMedium.orange5,
        ),
      ),
    );
  }
}
