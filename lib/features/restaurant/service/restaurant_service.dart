// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/restaurant/model/restaurant_model.dart';

const RESTAURANT_ENDPOINT = '/restaurant';

class RestaurantService {
  RestaurantService();

  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$RESTAURANT_ENDPOINT');

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
            "Une erreur s'est produite lors de la récupération des catégories. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<RestaurantModel> getRestaurantById(String restaurantId) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}$RESTAURANT_ENDPOINT/$restaurantId');

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
}
