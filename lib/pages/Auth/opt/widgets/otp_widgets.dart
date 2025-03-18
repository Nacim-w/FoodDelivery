import 'package:flutter/material.dart';
import 'package:testing/pages/Auth/auth_widgets/auth_widgets.dart';

String maskEmail(String email) {
  final RegExp regex = RegExp(r"^(.)(.*)(@.*)$");
  return email.replaceAllMapped(regex, (match) {
    String start = match.group(1)!; // First letter
    String middle = match.group(2)!; // Middle part (to be replaced)
    String domain = match.group(3)!; // Domain part

    String maskedMiddle = middle.isNotEmpty ? '*' * middle.length : '*';

    return "$start$maskedMiddle$domain";
  });
}

Widget otpForm(BuildContext context) {
  return Column(
    children: [
      buildAutoSizeText('Vérification par e-mail'),
      buildSlogan(
          "Entrez le code de vérification que nous vous avons envoyé à :${maskEmail("AlbertsTEST@gmail.com")}"),
    ],
  );
}
