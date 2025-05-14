import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/colours.dart';

class CategoryProvider extends ChangeNotifier {
  Color color;
  int index = 1;

  CategoryProvider({
    this.color = Colours.lightThemeRed5,
  });

  void changeColor({
    required Color newColor,
  }) async {
    color = newColor;
    notifyListeners();
  }

  void changeIndex({
    required int newIndex,
  }) async {
    index = newIndex;
    notifyListeners();
  }
}
