import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

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
                    style: TextStyles.textMedium.black1,
                  ),
                  TextSpan(
                    text: " Renvoyer",
                    style: canResend
                        ? TextStyles.textSemiBold.orange5
                        : TextStyles.textSemiBold.grey1,
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
      Icon(Icons.access_time_rounded, color: Colours.lightThemeGrey1),
      Gap(5),
      Text(
        formatTime(remainingSeconds),
        style: TextStyles.textMedium.grey1,
      ),
    ],
  );
}

String formatTime(int seconds) {
  int minutes = seconds ~/ 60;
  int secs = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
}
