import 'package:flutter/material.dart';

class PizzaDetailsProvider with ChangeNotifier {
  int quantity = 1;
  int selectedPizzaIndex = 0;

  String selectedSize = 'M';
  double rotationAngle = 0.0;

  final PageController pageController = PageController(initialPage: 0);

  List<Map<String, dynamic>> extras = [
    {'name': 'Sauce piquante', 'selected': false},
    {'name': 'Œuf frit', 'selected': false},
    {'name': 'Champignons', 'selected': false},
    {'name': 'Oignons caramélisés', 'selected': false},
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

  void setSelectedPizzaIndex(int index) {
    selectedPizzaIndex = index;
    notifyListeners();
  }

  void selectPizza(int index) {
    selectedPizzaIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void toggleExtra(int index, bool value) {
    extras[index]['selected'] = value;
    notifyListeners();
  }

  void setSize(String size) {
    selectedSize = size;
    rotationAngle = {'S': -0.1, 'M': 0.0, 'L': 0.1}[size] ?? 0.0;
    notifyListeners();
  }
}
