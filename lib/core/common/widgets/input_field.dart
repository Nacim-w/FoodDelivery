import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.controller,
    this.obscureText = false,
    this.defaultValidation = true,
    this.enabled = true,
    this.readOnly = false,
    this.expandable = false,
    super.key,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefix,
    this.contentPadding,
    this.prefixIcon,
    this.height,
    this.focusNode,
    this.onTap,
    this.suffixIconConstraints,
    this.onTapOutside,
    this.onSubmitted,
    this.fillColor,
    this.textColor,
    this.hintTextColor,
  });

  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintTextColor;
  final bool obscureText;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool expandable;
  final BoxConstraints? suffixIconConstraints;
  final ValueChanged<PointerDownEvent>? onTapOutside;
  final ValueChanged<String>? onSubmitted;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode,
        obscureText: obscureText,
        enabled: enabled,
        readOnly: readOnly,
        maxLines: expandable ? 5 : 1,
        minLines: expandable ? 1 : null,
        style: TextStyles.textRegular.black1,
        onTap: onTap,
        onTapOutside: onTapOutside,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
          hintStyle: TextStyles.textRegular.grey1,
          suffixIconColor: Colours.lightThemeGrey1,
          prefix: prefix,
          prefixIcon: prefixIcon,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
          filled: true,
          fillColor: fillColor ?? Colours.lightThemeBlack2,
        ),
        inputFormatters: inputFormatters,
        validator: defaultValidation
            ? (value) {
                if (value == null || value.isEmpty) return 'Required Field';
                return validator?.call(value);
              }
            : validator,
      ),
    );
  }
}
