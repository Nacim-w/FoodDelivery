import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';

void showToast(String message, {bool success = true}) {
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
