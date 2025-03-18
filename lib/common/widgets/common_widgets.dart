import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testing/common/res/styles/colours.dart';

AppBar buildAppBar(String name) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        color: Colours.lightThemePrimaryColor,
        height: 1.0,
      ),
    ),
    centerTitle: true,
    title: Text(
      name,
      style: TextStyle(
        color: Colours.lightThemePrimaryTextColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

toastInfo({
  required String msg,
  Color backgroundColor = Colours.lightThemePrimaryTextColor,
  Color textColor = Colours.lightThemePrimaryColor,
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

Widget reusableText(String text,
    {Color color = Colours.lightThemePrimaryTextColor,
    int fontSize = 14,
    FontWeight fontWeight = FontWeight.w600}) {
  return Text(
    text,
    style: TextStyle(
        color: color, fontWeight: fontWeight, fontSize: fontSize * 1.0),
  );
}
