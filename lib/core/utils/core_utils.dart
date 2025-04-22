import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legy/core/res/styles/colours.dart';

void showToast({required String message, bool success = true}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor:
        success ? Colours.lightThemeGreen5 : Colours.lightThemeRed5,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
