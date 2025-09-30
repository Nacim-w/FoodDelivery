import 'dart:convert';
import 'package:flutter/services.dart';

class MealDataLoader {
  static Future<String> loadMealDataPrompt(
      {String? filter, int minItems = 3}) async {
    List<dynamic> products = [];
    List<dynamic> restaurants = [];

    try {
      final productsJson =
          await rootBundle.loadString('assets/data/legy.products.json');
      final restaurantsJson =
          await rootBundle.loadString('assets/data/legy.restaurants.json');
      products = jsonDecode(productsJson) as List<dynamic>;
      restaurants = jsonDecode(restaurantsJson) as List<dynamic>;
    } catch (e) {
      return "Menu data could not be loaded: ${e.toString()}";
    }

    final lowerFilter = filter?.toLowerCase().trim() ?? '';

    List<dynamic> filteredRestaurants = restaurants;
    List<dynamic> filteredProducts = products;

    if (lowerFilter.isNotEmpty) {
      filteredRestaurants = restaurants.where((r) {
        final name = (r['nom'] ?? '').toString().toLowerCase();
        final desc = (r['description'] ?? '').toString().toLowerCase();
        return name.contains(lowerFilter) || desc.contains(lowerFilter);
      }).toList();

      final restaurantIds = filteredRestaurants
          .map((r) => (r['_id']?['\$oid'] ?? r['id'] ?? '').toString())
          .toSet();

      filteredProducts = products.where((p) {
        final name = (p['name'] ?? '').toString().toLowerCase();
        final desc = (p['description'] ?? '').toString().toLowerCase();
        final restId = (p['restaurantId'] ?? '').toString();
        return name.contains(lowerFilter) ||
            desc.contains(lowerFilter) ||
            restaurantIds.contains(restId);
      }).toList();
    }

    return _buildMenuString(
      filteredRestaurants.take(10).toList(),
      filteredProducts.take(20).toList(),
    );
  }

  static String truncate(String text, int maxLength) =>
      text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';

  static String _buildMenuString(
      List<dynamic> restaurants, List<dynamic> products) {
    final buffer = StringBuffer();
    buffer.writeln("Menu:");

    for (final r in restaurants) {
      buffer.writeln("Restaurant: ${r['nom'] ?? 'Unknown'}");
    }

    for (final p in products) {
      final name = p['name'] ?? 'Unknown';
      final price =
          (p['price'] ?? p['pricePreCom'] ?? p['pricePostCom'] ?? 'Unknown')
              .toString();
      final desc = truncate((p['description'] ?? '').toString(), 40);
      buffer.writeln("Product: $name - $price DT - $desc");
    }

    return buffer.toString();
  }
}
