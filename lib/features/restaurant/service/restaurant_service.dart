// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
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
      debugPrint("Response Status Code: ${response.statusCode}");
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);
      debugPrint("Decoded Data: $data");

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
}
