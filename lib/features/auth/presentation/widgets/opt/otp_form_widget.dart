import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/auth/presentation/app/adapter/auth_cubit.dart';
import 'package:legy/features/auth/presentation/views/change_password_view.dart';
import 'package:legy/features/auth/presentation/views/forgot_password_view.dart';
import 'package:legy/features/auth/presentation/views/otp_view.dart';
import 'package:legy/features/auth/presentation/views/sign_in_view.dart';
import 'package:legy/features/auth/presentation/widgets/opt/otp_widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _otpController = TextEditingController();

  bool canResend = false;
  int remainingSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      canResend = false;
      remainingSeconds = 60; // countdown duration in seconds
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        setState(() {
          canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  Future<void> onResendPressed() async {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final email = extra['email'] as String;

    try {
      await context.read<AuthCubit>().sendResetCode(email);
      startCountdown();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le code a été renvoyé")),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors du renvoi : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    final email = extra['email'] as String;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is CodeVerified) {
          context.push(
            '${SignInPage.routePath}/${ForgotPasswordView.routePath}/${OtpView.routePath}/${ChangePasswordPage.routePath}',
            extra: {
              'email': state.email,
              'code': state.code,
            },
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const Gap(30),
            buildAutoSizeText('Vérification par e-mail'),
            Text(
              "Entrez le code de vérification que nous vous avons envoyé à : ${maskEmail(email)}",
              style: TextStyles.textMedium.grey1,
            ),
            const Gap(40),
            Center(
              child: Pinput(
                length: 6,
                controller: _otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
              ),
            ),
            const Gap(20),
            resendOtpText(canResend, remainingSeconds, onResendPressed),
            const Gap(20),
            resendOtpTimer(remainingSeconds),
            const Gap(40),
            BuildLogInAndRegButton(
              "Continuer",
              "continuer",
              () {
                final code = _otpController.text;
                if (code.length == 6) {
                  context.read<AuthCubit>().verifyCode(email, code);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Veuillez entrer un code à 6 chiffres")),
                  );
                }
              },
            ),
            if (state is AuthLoading) const CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 75,
  height: 72,
  textStyle: TextStyles.otpDefault.black1,
  decoration: BoxDecoration(
    border: Border.all(color: Colours.lightThemeGrey2),
    borderRadius: BorderRadius.circular(12),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: Colours.lightThemeOrange5),
  borderRadius: BorderRadius.circular(12),
);

String maskEmail(String email) {
  final RegExp regex = RegExp(r"^(.{2,4})(.*)(@.*)$");
  return email.replaceAllMapped(regex, (match) {
    String start = match.group(1)!;
    String masked = '*' * match.group(2)!.length;
    String domain = match.group(3)!;
    return "$start$masked$domain";
  });
}
