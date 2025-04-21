import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:legy/features/auth/presentation/views/change_password_view.dart';
import 'package:legy/features/auth/presentation/widgets/opt/otp_widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/auth_widgets.dart';
import 'package:legy/features/auth/presentation/widgets/auth_widgets/build_login_reg_widget.dart';

class OtpForm extends StatefulWidget {
  final bool canResend;
  final int remainingSeconds;
  final VoidCallback startTimer;

  const OtpForm({
    super.key,
    required this.canResend,
    required this.remainingSeconds,
    required this.startTimer,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(30),
        buildAutoSizeText('Vérification par e-mail'),
        Text(
            "Entrez le code de vérification que nous vous avons envoyé à : ${maskEmail("AlbertsTEST@gmail.com")}",
            style: TextStyles.textMedium.grey1),
        Gap(40),
        Center(
          child: Pinput(
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
          ),
        ),
        Gap(20),
        resendOtpText(
            widget.canResend, widget.remainingSeconds, widget.startTimer),
        Gap(20),
        resendOtpTimer(widget.remainingSeconds),
        Gap(40),
        BuildLogInAndRegButton(
          "Continuer",
          "continuer",
          () => context.go(ChangePasswordPage.routePath),
        ),
      ],
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
    String start = match.group(1)!; // First 2 to 4 characters
    String masked =
        '*' * match.group(2)!.length; // Replace middle part with '*'
    String domain = match.group(3)!; // Domain part
    return "$start$masked$domain";
  });
}
