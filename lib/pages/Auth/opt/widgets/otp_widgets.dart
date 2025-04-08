import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

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
                  TextSpan(
                    text: " Renvoyer",
                    style: canResend
                        ? TextStyles.textSemiBold.orange
                        : TextStyles.textSemiBold.grey,
                    recognizer: TapGestureRecognizer()
                      ..onTap = canResend ? startTimer : null,
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

String formatTime(int seconds) {
  int minutes = seconds ~/ 60;
  int secs = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
}
