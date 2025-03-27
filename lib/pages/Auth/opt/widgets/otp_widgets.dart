import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:testing/pages/auth/change_password/change_password_page.dart';

String formatTime(int seconds) {
  int minutes = seconds ~/ 60;
  int secs = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
}

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

final defaultPinTheme = PinTheme(
  width: 75,
  height: 72,
  textStyle: TextStyles.otpDefault.black,
  decoration: BoxDecoration(
    border: Border.all(color: Colours.lightThemeSecondaryTextColor),
    borderRadius: BorderRadius.circular(12),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: Colours.lightThemeOrangeTextColor),
  borderRadius: BorderRadius.circular(12),
);
Widget resendOtpText(
    bool canResend, int remainingSeconds, VoidCallback startTimer) {
  return Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: canResend ? startTimer : null,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Vous n'avez pas reçu le code ?",
                    style: TextStyles.textMedium.black,
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: canResend ? startTimer : null,
                      child: Text(
                        " Renvoyer",
                        style: canResend
                            ? TextStyles.textSemiBold.orange
                            : TextStyles.textSemiBold.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget resendOtpTimer(int remainingSeconds) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.access_time_rounded,
          color: Colours.lightThemeSecondaryTextColor),
      Gap(5),
      Text(
        formatTime(remainingSeconds),
        style: TextStyles.textMedium.grey,
      ),
    ],
  );
}

Widget otpForm(BuildContext context, bool canResend, int remainingSeconds,
    VoidCallback startTimer) {
  return Column(
    children: [
      Gap(30),
      buildAutoSizeText('Vérification par e-mail'),
      buildSlogan(
          "Entrez le code de vérification que nous vous avons envoyé à : ${maskEmail("AlbertsTEST@gmail.com")}"),
      Gap(40),
      Center(
        child: Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
        ),
      ),
      Gap(20),
      resendOtpText(canResend, remainingSeconds, startTimer),
      Gap(20),
      resendOtpTimer(remainingSeconds),
      Gap(40),
      buildLogInAndRegButton(
        context,
        "Continuer",
        "continuer",
        () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ChangePasswordPage(),
            ),
          );
        },
      ),
    ],
  );
}
