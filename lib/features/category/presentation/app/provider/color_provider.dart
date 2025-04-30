import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';

class ColorProvider extends ChangeNotifier {
  Color color;
  ColorProvider({
    this.color = Colours.lightThemeRed5,
  });
  void changeColor({
    required Color newColor,
  }) async {
    color = newColor;
    notifyListeners();
  }
}
