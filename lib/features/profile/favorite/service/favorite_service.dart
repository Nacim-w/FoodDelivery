// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';

const FAVORITE_ENDPOINT = '/favorites';
const FAVORITE_PRODUCT_ENDPOINT = '/favorites/products';

class FavoriteService {
  final CacheHelper _cacheHelper;

  FavoriteService(this._cacheHelper);

  Future<String> getFavoriteRestaurant() async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$FAVORITE_ENDPOINT');
      final token = _cacheHelper.getSessionToken();
      debugPrint('URI: $uri');

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await getFavoriteRestaurant();
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage =
            errorJson['error'] ?? 'Une erreur est survenue (add favorite).';
        throw ServerException(message: errorMessage);
      }

      return response.body; // ✅ return the body for use in Cubit
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de l'ajout aux favoris. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<String> getFavoriteProduct() async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$FAVORITE_PRODUCT_ENDPOINT');
      final token = _cacheHelper.getSessionToken();
      final refreshToken = _cacheHelper.getRefreshToken();

      debugPrint('Token: $token');
      debugPrint('Refresh Token: $refreshToken');
      debugPrint('URI: $uri');

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await getFavoriteProduct();
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage =
            errorJson['error'] ?? 'Une erreur est survenue (remove favorite).';
        throw ServerException(message: errorMessage);
      }

      return response.body; // ✅ return the body for use in Cubit
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la suppression des favoris. Veuillez réessayer plus tard.",
      );
    }
  }
}
