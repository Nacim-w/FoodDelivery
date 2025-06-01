// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/category/model/category_restaurant_model.dart';

const RESTAURANT_ENDPOINT = '/restaurant';
const POPULAR_RESTAURANT_ENDPOINT = '$RESTAURANT_ENDPOINT/popular';

class CategoryService {
  CategoryService();

  Future<List<CategoryRestaurantModel>> getPopularRestaurants({
    required String main,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$POPULAR_RESTAURANT_ENDPOINT')
              .replace(queryParameters: {
        'main': main,
      });
      debugPrint('Request URI: $uri');
      final response = await http.get(
        uri,
        headers: NetworkConstants.headers,
      );
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final responseBody = utf8.decode(response.bodyBytes);
      final decoded = jsonDecode(responseBody);

      // FIX: Access the 'content' list inside the response
      final List data = decoded['content'];

      List<CategoryRestaurantModel> restaurants = data
          .map((restaurantJson) =>
              CategoryRestaurantModel.fromJson(restaurantJson))
          .toList();

      return restaurants;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la récupération des restaurants. Veuillez réessayer plus tard.",
      );
    }
  }
}
