import 'dart:convert';
import 'package:flutter/services.dart';

class MealDataLoader {
  static Future<String> loadMealDataPrompt({
    String? filter,
    int minItems = 3,
  }) async {
    final productsJson =
        await rootBundle.loadString('assets/data/legy.products.json');
    final restaurantsJson =
        await rootBundle.loadString('assets/data/legy.restaurants.json');

    final products = jsonDecode(productsJson) as List<dynamic>;
    final restaurants = jsonDecode(restaurantsJson) as List<dynamic>;

    if (filter == null || filter.trim().isEmpty) {
      return _buildMenuString(
        restaurants.take(10).toList(),
        products.take(20).toList(),
      );
    }

    final lowerFilter = filter.toLowerCase();

    List<dynamic> filterRestaurants(int level) {
      switch (level) {
        case 1:
          return restaurants.where((r) {
            final name = (r['nom'] ?? '').toString().toLowerCase();
            final desc = (r['description'] ?? '').toString().toLowerCase();
            return name.contains(lowerFilter) || desc.contains(lowerFilter);
          }).toList();
        case 2:
          final words = lowerFilter.split(' ');
          return restaurants.where((r) {
            final name = (r['nom'] ?? '').toString().toLowerCase();
            final desc = (r['description'] ?? '').toString().toLowerCase();
            return words.any(
              (w) => w.isNotEmpty && (name.contains(w) || desc.contains(w)),
            );
          }).toList();
        default:
          return restaurants;
      }
    }

    List<dynamic> filterProducts(List<dynamic> filteredRestaurants, int level) {
      final filteredRestaurantIds = filteredRestaurants
          .map((r) => (r['_id']?['\$oid'] ?? r['id'] ?? '').toString())
          .toSet();

      switch (level) {
        case 1:
          return products.where((p) {
            final name = (p['name'] ?? '').toString().toLowerCase();
            final desc = (p['description'] ?? '').toString().toLowerCase();
            final restId = (p['restaurantId'] ?? '').toString();
            return name.contains(lowerFilter) ||
                desc.contains(lowerFilter) ||
                filteredRestaurantIds.contains(restId);
          }).toList();
        case 2:
          final words = lowerFilter.split(' ');
          return products.where((p) {
            final name = (p['name'] ?? '').toString().toLowerCase();
            final desc = (p['description'] ?? '').toString().toLowerCase();
            final restId = (p['restaurantId'] ?? '').toString();
            return words.any((w) =>
                    w.isNotEmpty && (name.contains(w) || desc.contains(w))) ||
                filteredRestaurantIds.contains(restId);
          }).toList();
        default:
          return products;
      }
    }

    // Try filtering by levels, and increase output size if needed
    for (int level = 1; level <= 3; level++) {
      final filteredRestaurants = filterRestaurants(level);
      final filteredProducts = filterProducts(filteredRestaurants, level);

      final restaurantCount = filteredRestaurants.length;
      final productCount = filteredProducts.length;

      if (restaurantCount >= minItems && productCount >= minItems) {
        return _buildMenuString(
          filteredRestaurants.take(10).toList(),
          filteredProducts.take(20).toList(),
        );
      }

      // Not enough, but there's some — expand
      if (restaurantCount > 0 && productCount > 0) {
        return _buildMenuString(
          filteredRestaurants.take(15).toList(),
          filteredProducts.take(40).toList(),
        );
      }
    }

    // Final fallback: show unfiltered example
    return _buildMenuString(
      restaurants.take(20).toList(),
      products.take(40).toList(),
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
          p['price'] ?? p['pricePreCom'] ?? p['pricePostCom'] ?? 'Unknown';
      final desc = truncate((p['description'] ?? '').toString(), 40);
      buffer.writeln("Product: $name - $price DT - $desc");
    }

    return buffer.toString();
  }
}
