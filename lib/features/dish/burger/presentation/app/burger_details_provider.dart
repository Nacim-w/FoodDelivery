import 'package:flutter/material.dart';

class BurgerDetailsProvider with ChangeNotifier {
  int quantity = 1;
  int selectedBurgerIndex = 0;

  final PageController pageController = PageController(initialPage: 0);
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

  void selectBurger(int index) {
    selectedBurgerIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void setSelectedBurgerIndex(int index) {
    selectedBurgerIndex = index;
    notifyListeners();
  }
}
