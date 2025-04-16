import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legy/common/res/styles/colours.dart';

toastInfo({
  required String msg,
  Color backgroundColor = Colours.lightThemeOrange5,
  Color textColor = Colours.lightThemeWhite1,
}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}
