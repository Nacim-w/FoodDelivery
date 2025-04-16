import 'package:flutter/material.dart';
import 'package:legy/common/res/styles/colours.dart';

class CheckboxWidget extends StatefulWidget {
  final bool isChecked;
  final void Function(bool?) handleCheckboxChange;

  const CheckboxWidget(
      {super.key, required this.isChecked, required this.handleCheckboxChange});

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      side: BorderSide(
        color: Colours.lightThemeOrange5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      fillColor: WidgetStateProperty.all(Colours.lightThemeOrange5),
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
        });
        widget.handleCheckboxChange(value);
      },
    );
  }
}
