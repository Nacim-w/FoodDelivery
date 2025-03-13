import 'package:testing/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/res/media.dart';

AppBar buildAppBar(String name) {
  return AppBar(
      bottom: PreferredSize(
          child: Container(
            color: AppColors.primarySecondaryBackground,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0)),
      centerTitle: true,
      title: Text(
        name,
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ));
}

Widget buildSlogan(String slogan) {
  return Text(
    slogan,
    style: TextStyle(
      color: Color(0x87878787),
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget goToText(Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Text(
      "S'inscrire",
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Color(0xFFFF7300),
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,
      ),
    ),
  );
}

Widget buildThirdPartyLogin(BuildContext context) {
  return Center(
    child: Container(
      width: 300,
      margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
      padding: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          reusableIcons(Media.google),
          reusableIcons(Media.facebook),
          reusableIcons(Media.apple),
        ],
      ),
    ),
  );
}

Widget reusableIcons(String url) {
  return GestureDetector(
    child: Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFD6D6D6), width: 2),
      ),
      child: Center(
        child: Image.asset(url, width: 20, height: 20),
      ),
    ),
    onTap: () {},
  );
}

Widget buildTextField(String hintText, String textType) {
  bool obscureText = textType == "password";

  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        width: 325.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(color: AppColors.primaryThreeElementText),
        ),
        child: SizedBox(
          width: 280.w,
          height: 50.h,
          child: TextField(
            keyboardType: textType == "password"
                ? TextInputType.text
                : TextInputType.multiline,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: textType == "password"
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF101010),
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )
                  : null, // No eye icon for non-password fields
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            autocorrect: false,
            obscureText: obscureText, // Toggle the visibility
          ),
        ),
      );
    },
  );
}

Widget buildLogInAndRegButton(
    String buttonName, String buttonType, Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Color(0xFFFF7300),
        borderRadius: BorderRadius.all(
          Radius.circular(100.w),
        ),
        border: Border.all(
          color: buttonType == "login"
              ? Colors.transparent
              : AppColors.primaryFourElementText,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    ),
  );
}
