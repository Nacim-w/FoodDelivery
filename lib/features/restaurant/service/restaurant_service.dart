// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/restaurant/model/restaurant_category_model.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';
import 'package:legy/features/restaurant/model/restaurant_product_model.dart';

const RESTAURANT_ENDPOINT = '/restaurant';
const ALL_RESTAURANTS_ENDPOINT = '$RESTAURANT_ENDPOINT/get-all-restaurants';
const RESTAURANT_BY_ID_ENDPOINT = '$RESTAURANT_ENDPOINT/get-restaurant-by-id';
const CATEGORIES_ENDPOINT = '/categories';
const PRODUCT_CATEGORY_ENDPOINT = '/products';

class RestaurantService {
  RestaurantService();

  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$ALL_RESTAURANTS_ENDPOINT');
      final response = await http.get(
        uri,
        headers: NetworkConstants.headers,
      );
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }
      final data = jsonDecode(response.body);

      if (data is List) {
        List<RestaurantModel> restaurants = data
            .map((categoryJson) => RestaurantModel.fromJson(categoryJson))
            .toList();

        return restaurants;
      } else {
        throw ServerException(
          message: "Invalid data format received. Expected a list.",
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la récupération des restaurants. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<RestaurantModel> getRestaurantById(String restaurantId) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}$RESTAURANT_BY_ID_ENDPOINT/$restaurantId');
      final response = await http.get(
        uri,
        headers: NetworkConstants.headers,
      );
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'test error';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);
      if (data is Map) {
        return RestaurantModel.fromJson(data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: "Invalid data format received. Expected a single object.",
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la récupération du restaurant. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<List<RestaurantCategoryModel>> getRestaurantCategoriesById(
      String restaurantId) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}$RESTAURANT_ENDPOINT/$restaurantId$CATEGORIES_ENDPOINT');

      final response = await http.get(
        uri,
        headers: NetworkConstants.headers,
      );
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);
      if (data is List) {
        return data
            .map((categoryJson) =>
                RestaurantCategoryModel.fromJson(categoryJson))
            .toList();
      } else {
        throw ServerException(
          message: "Invalid data format received. Expected a list.",
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la récupération des catégories. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<List<RestaurantProductModel>> getRestaurantProducts(
      String restaurantId, String categoryId) async {
    try {
      final queryParams = {'categoryId': categoryId};

      final uri = NetworkConstants.baseUrl.startsWith('https')
          ? Uri.https(
              NetworkConstants.developAuthority,
              '$RESTAURANT_ENDPOINT/$restaurantId$PRODUCT_CATEGORY_ENDPOINT',
              queryParams,
            )
          : Uri.http(
              NetworkConstants.localhostAuthority,
              '$RESTAURANT_ENDPOINT/$restaurantId$PRODUCT_CATEGORY_ENDPOINT',
              queryParams,
            );
      debugPrint('URI: $uri');
      final response = await http.get(
        uri,
        headers: NetworkConstants.headers,
      );

      debugPrint('Response: ${response.body}');

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);
      if (data is List) {
        return data
            .map((productJson) => RestaurantProductModel.fromJson(productJson))
            .toList();
      } else {
        throw ServerException(
          message: "Invalid data format received. Expected a list.",
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la récupération des Produits. Veuillez réessayer plus tard.",
      );
    }
  }
}
