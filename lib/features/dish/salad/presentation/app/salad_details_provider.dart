import 'package:flutter/material.dart';

class SaladDetailsProvider with ChangeNotifier {
  int quantity = 1;
  int selectedSaladIndex = 0;
  List<Map<String, dynamic>> extras = [
    {'name': 'Huile de noix', 'selected': false},
    {'name': 'brocoli', 'selected': false},
    {'name': 'pâtes', 'selected': false},
    {'name': 'haricots bouillis', 'selected': false},
  ];

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void selectSalad(int index) {
    selectedSaladIndex = index;
    notifyListeners();
  }

  void toggleExtra(int index, bool value) {
    extras[index]['selected'] = value;
    notifyListeners();
  }
}
