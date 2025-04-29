import 'package:flutter/material.dart';
import 'package:legy/core/extension/media_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({super.key});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.lightThemeGreen0,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ToggleSwitch(
        initialLabelIndex: selectedIndex,
        totalSwitches: 2,
        labels: const ['Nouveau', 'Ancien'],
        onToggle: (index) {
          setState(() {
            selectedIndex = index!;
          });
        },
        radiusStyle: true,
        minWidth: context.width * 0.4,
        cornerRadius: 30.0,
        activeBgColor: const [Colors.white],
        inactiveBgColor: Colors.transparent,
        activeFgColor: Colours.lightThemeBlack1,
        inactiveFgColor: Colours.lightThemeGrey1,
        borderColor: const [Colors.transparent],
        customTextStyles: [TextStyles.textSemiBoldLarge],
      ),
    );
  }
}
