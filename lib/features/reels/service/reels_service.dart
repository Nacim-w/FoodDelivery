// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/home/model/story_model.dart';

const GET_REELS_ENDPOINT = '/api/all-reels';

class ReelsService {
  ReelsService();
  Future<List<StoryItemModel>> getReels() async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$GET_REELS_ENDPOINT');

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
      debugPrint('Response data: ${data.toString()}');

      if (data is List) {
        List<StoryItemModel> stories = data
            .map((categoryJson) => StoryItemModel.fromJson(categoryJson))
            .toList();

        return stories;
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
