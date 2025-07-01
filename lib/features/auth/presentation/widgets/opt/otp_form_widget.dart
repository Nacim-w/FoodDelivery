import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/core/common/widgets/rounded_button.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/widget_extensions.dart';
import 'package:legy/core/res/media.dart';
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

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _otpController = TextEditingController();

  bool canResend = false;
  bool isResending = false;
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
      remainingSeconds = 60;
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

    setState(() => isResending = true);

    try {
      await context.read<AuthCubit>().sendResetCode(email);
      startCountdown();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le code a été renvoyé")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors du renvoi : $e")),
      );
    } finally {
      if (mounted) setState(() => isResending = false);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.adaptiveGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colours.lightThemeWhite1,
                    border: Border.all(
                      color: Colours.lightThemeGrey1.withAlpha(80),
                    ),
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(Media.authArrow),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Gap(20),
            SizedBox(
              width: context.width * 0.7,
              child: Text(
                'Vérification par e-mail',
                style: TextStyles.titleBoldLarge.orange5,
              ),
            ),
            Gap(15),
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

            // LOADING SPINNER FOR RESEND
            if (isResending)
              const Center(child: CircularProgressIndicator())
            else
              Align(
                alignment: Alignment.center,
                child:
                    resendOtpText(canResend, remainingSeconds, onResendPressed),
              ),

            const Gap(20),
            resendOtpTimer(remainingSeconds),
            const Gap(40),

            RoundedButton(
              backgroundColour: Colours.lightThemeOrange5,
              text: "Continuer",
              onPressed: () {
                final code = _otpController.text;
                if (code.length == 6) {
                  context.read<AuthCubit>().verifyCode(email, code);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Veuillez entrer un code à 6 chiffres"),
                    ),
                  );
                }
              },
            ).loading(state is AuthLoading),
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
