import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget forgotPassword() {
  return SizedBox(
    width: 325.w,
    height: 44.h,
    child: GestureDetector(
        child: Text(
          "Mot de passe oublié?",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFFFF7300),
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          ),
        ),
        onTap: () {}),
  );
}
