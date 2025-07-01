import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/common/widgets/vertical_label_field.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/core/utils/core_utils.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/auth/presentation/views/forgot_password_view.dart';
import 'package:legy/features/auth/presentation/views/otp_view.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is CodeSentSuccessfully) {
          context.go(
            '${SignInPage.routePath}/${ForgotPasswordView.routePath}/${OtpView.routePath}',
            extra: {'email': _emailController.text.trim()},
          );
        } else if (state is AuthError) {
          showToast(message: state.message, success: false);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mot de passe oublié?",
                style: TextStyles.titleBoldLarge.orange5,
              ),
              Gap(10),
              Text(
                "Saisissez votre e-mail pour recevoir un code de réinitialisation.",
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
                  final emailRegex =
                      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                  if (!emailRegex.hasMatch(value)) {
                    return "Veuillez entrer une adresse e-mail valide";
                  }
                  return null;
                },
              ),
              Gap(60),
              RoundedButton(
                backgroundColour: Colours.lightThemeOrange5,
                text: "Se connecter",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final email = _emailController.text.trim();
                    context.read<AuthCubit>().sendResetCode(email);
                  }
                },
              ).loading(state is AuthLoading),
            ],
          ),
        );
      },
    );
  }
}
