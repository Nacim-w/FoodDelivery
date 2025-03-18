import 'package:flutter/widgets.dart';

abstract class TextStyles {
  static const TextStyle headingBold = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle textMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
  static const TextStyle textSemiBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
  static const TextStyle otpDefault =
      TextStyle(fontSize: 32, fontWeight: FontWeight.w500);
}
