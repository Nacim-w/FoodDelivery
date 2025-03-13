import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reusableText(String text,
    {Color color = const Color(0xFF101010),
    int fontSize = 14,
    FontWeight fontWeight = FontWeight.w500}) {
  return Text(
    text,
    style:
        TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize.sp),
  );
}
