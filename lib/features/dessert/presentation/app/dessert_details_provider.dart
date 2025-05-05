import 'package:flutter/material.dart';

class DessertDetailsProvider with ChangeNotifier {
  int quantity = 1;
  int selectedDessertIndex = 0;
  List<Map<String, dynamic>> extras = [
    {'name': 'Huile de noix', 'selected': false},
    {'name': 'brocoli', 'selected': false},
    {'name': 'pâtes', 'selected': false},
    {'name': 'haricots bouillis', 'selected': false},
  ];

  void increment() {
    if (quantity < 99) {
      quantity++;
      notifyListeners();
    }
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  void selectDessert(int index) {
    selectedDessertIndex = index;
    notifyListeners();
  }
}
