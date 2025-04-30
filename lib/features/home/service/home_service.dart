// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/home/model/nearby_restaurant_model.dart';
import 'package:legy/features/home/model/top_category_model.dart';

const CATEGORIES_ENDPOINT = '/categories';
const RESTAURANT_ENDPOINT = '/restaurant';
const TOP_CATEGORIES_ENDPOINT = '$CATEGORIES_ENDPOINT/top';
const NEARBY_RESTAURANT_ENDPOINT = '$RESTAURANT_ENDPOINT/nearby';

class HomeService {
  HomeService();

  Future<List<TopCategoryModel>> getTopCategories() async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$TOP_CATEGORIES_ENDPOINT');

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
      debugPrint("Decoded Data: $data");

      if (data is List) {
        List<TopCategoryModel> categories = data
            .map((categoryJson) => TopCategoryModel.fromJson(categoryJson))
            .toList();

        return categories;
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

  Future<List<NearbyRestaurantModel>> getNearbyRestaurants({
    required double longitude,
    required double latitude,
    required double maxDistanceKm,
    required int limit,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$NEARBY_RESTAURANT_ENDPOINT')
              .replace(queryParameters: {
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'maxDistanceKm': maxDistanceKm.toString(),
        'limit': limit.toString(),
      });

      final response = await http.get(
        uri,
        headers: NetworkConstants.headers,
      );

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");
      debugPrint("Response Headers: ${response.headers}");
      debugPrint("Response URI: ${response.request?.url}");
      final List data = jsonDecode(response.body);

      debugPrint("Decoded Data: $data");

      List<NearbyRestaurantModel> restaurants = data
          .map((restaurantJson) =>
              NearbyRestaurantModel.fromJson(restaurantJson))
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
