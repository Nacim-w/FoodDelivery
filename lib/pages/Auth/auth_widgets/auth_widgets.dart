import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testing/common/extensions/text_style_extension.dart';
import 'package:testing/common/res/media.dart';
import 'package:testing/common/res/styles/colours.dart';
import 'package:testing/common/res/styles/text.dart';

Widget buildAutoSizeText(String text) {
  return AutoSizeText(
    text,
    style: TextStyles.titleMedium.black,
    maxLines: 2,
  );
}

class BuildTextField extends StatefulWidget {
  final String hintText;
  final String textType;

  const BuildTextField({
    super.key,
    required this.hintText,
    required this.textType,
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Colours.lightThemePrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colours.lightThemeBorderColor),
      ),
      child: TextField(
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
            color: Colours.lightThemeSecondaryTextColor,
          ),
          suffixIcon: widget.textType == "password"
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colours.lightThemePrimaryTextColor,
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
                      color: Colours.lightThemePrimaryTextColor,
                    )
                  : null,
        ),
        style: TextStyles.textMedium.black,
        autocorrect: false,
        obscureText: obscureText,
        readOnly: widget.textType == "sex",
        onTap: widget.textType == "sex" ? () {} : null,
      ),
    );
  }
}

Widget buildLogInAndRegButton(BuildContext context, String buttonName,
    String buttonType, Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colours.lightThemeOrangeTextColor,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: TextStyles.textSemiBold.white,
        ),
      ),
    ),
  );
}

Widget buildThirdPartyLogin(BuildContext context) {
  return Center(
    child: Container(
      width: 300,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      padding: EdgeInsets.only(left: 0, right: 0),
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
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colours.lightThemeBorderColor, width: 2),
      ),
      child: Center(
        child: Image.asset(url, width: 20, height: 20),
      ),
    ),
    onTap: () {},
  );
}

Widget buildSeperater(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 1,
        child: Divider(
          color: Colours.lightThemeSecondaryTextColor,
          thickness: 0.5,
        ),
      ),
      Flexible(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Ou connectez-vous avec",
            style: TextStyles.textMedium.grey,
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: Divider(
          color: Colours.lightThemeSecondaryTextColor,
          thickness: 0.5,
        ),
      ),
    ],
  );
}

Widget goToLegal(Function()? func, String text, String type) {
  return GestureDetector(
    onTap: func,
    child: Text(text, style: TextStyles.textSemiBold.orange),
  );
}
