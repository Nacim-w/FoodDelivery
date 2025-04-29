import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  RangeValues priceRange = const RangeValues(20, 40);

  @override
  Widget build(BuildContext context) {
    return SfRangeSlider(
      min: 10.0,
      max: 50.0,
      values: SfRangeValues(priceRange.start, priceRange.end),
      interval: 10,
      showLabels: true,
      activeColor: Colours.lightThemeYellow5,
      inactiveColor: Colours.lightThemeGrey2,
      onChanged: (SfRangeValues newValues) {
        setState(() {
          priceRange = RangeValues(newValues.start, newValues.end);
        });
      },
    );
  }
}
