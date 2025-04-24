import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

Widget buildAutoSizeText(String text) {
  return AutoSizeText(
    text,
    style: TextStyles.titleMedium.black2,
    maxLines: 2,
  );
}

class BuildTextField extends StatefulWidget {
  final String hintText;
  final String textType;
  final TextEditingController? controller; // Added controller

  const BuildTextField({
    super.key,
    required this.hintText,
    required this.textType,
    this.controller, // Accept controller as optional
  });

  @override
  State<BuildTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<BuildTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.textType == "password";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.width,
      height: context.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colours.lightThemeGrey2),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textType == "password"
            ? TextInputType.text
            : TextInputType.multiline,
        decoration: InputDecoration(
          hintText: widget.hintText,
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
            color: Colours.lightThemeGrey1,
          ),
          suffixIcon: widget.textType == "password"
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colours.lightThemeBlack2,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : widget.textType == "sex"
                  ? Icon(
                      Icons.arrow_drop_down,
                      color: Colours.lightThemeBlack2,
                    )
                  : null,
        ),
        style: TextStyles.textMedium.black1,
        autocorrect: false,
        obscureText: obscureText,
        readOnly: widget.textType == "sex",
        onTap: widget.textType == "sex" ? () {} : null,
      ),
    );
  }
}

Widget reusableIcons(String url) {
  return GestureDetector(
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colours.lightThemeGrey2, width: 2),
      ),
      child: Center(
        child: Image.asset(url, width: 20, height: 20),
      ),
    ),
    onTap: () {},
  );
}

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange5),
  );
}
