import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(
      text,
      style: TextStyle(
        color: Color(0xFFFF7300),
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
      ),
    ),
  );
}
