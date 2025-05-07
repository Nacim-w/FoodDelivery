import 'package:flutter/material.dart';
import 'package:legy/core/res/media.dart';

class RestaurantProductProvider extends ChangeNotifier {
  String _selectedCategory = 'Petit Déjeuner';

  String get selectedCategory => _selectedCategory;

  void changeCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  List<Map<String, String>> get products {
    switch (_selectedCategory) {
      case 'pizzas':
        return List.generate(
            5,
            (i) => {
                  'image': Media.restaurant1,
                  'title': 'Pizza Margherita ${i + 1}',
                  'description': 'Tasty pizza ${i + 1}',
                  'time': '20-${25 + i} mins',
                  'distance': '${6 + i} km',
                  'rating': (4.0 + i * 0.2).toStringAsFixed(1),
                });
      case 'Plats':
        return List.generate(
            3,
            (i) => {
                  'image': Media.restaurant1,
                  'title': 'Main Course ${i + 1}',
                  'description': 'Traditional dish ${i + 1}',
                  'time': '30-${35 + i} mins',
                  'distance': '${7 + i * 0.5} km',
                  'rating': (4.5 + i * 0.1).toStringAsFixed(1),
                });
      default:
        return List.generate(
            4,
            (i) => {
                  'image': Media.restaurant1,
                  'title': 'Breakfast ${i + 1}',
                  'description': 'Croissant and coffee ${i + 1}',
                  'time': '10-${15 + i} mins',
                  'distance': '${5 + i} km',
                  'rating': (4.2 + i * 0.1).toStringAsFixed(1),
                });
    }
  }
}
