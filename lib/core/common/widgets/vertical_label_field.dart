
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/res/styles/text.dart';

import 'input_field.dart';

class VerticalLabelField extends StatelessWidget {
  const VerticalLabelField({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.defaultValidation = true,
    this.enabled = true,
    this.readOnly = false,
    this.mainFieldFlex = 1,
    this.prefixFlex = 1,
    super.key,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefix,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
    this.onTap, this.suffixIconConstraints,
  });

  final String label;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final BoxConstraints? suffixIconConstraints;

  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final int mainFieldFlex;
  final int prefixFlex;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.textBoldLarge,
        ),
        const Gap(10),
        Row(
          children: [
            if (prefix != null) ...[
              Expanded(flex: prefixFlex, child: prefix!),
              const Gap(8)
            ],
            Expanded(
              flex: mainFieldFlex,
              child: InputField(
                controller: controller,
                focusNode: focusNode,
                suffixIcon: suffixIcon,
                onTap: onTap,
                hintText: hintText,
                validator: validator,
                keyboardType: keyboardType,
                obscureText: obscureText,
                suffixIconConstraints: suffixIconConstraints,
                defaultValidation: defaultValidation,
                inputFormatters: inputFormatters,
                enabled: enabled,
                readOnly: readOnly,
                contentPadding: contentPadding,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
