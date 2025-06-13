// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/home/model/nearby_restaurant_model.dart';
import 'package:legy/features/home/model/top_category_model.dart';

const CATEGORIES_ENDPOINT = '/categories';
const RESTAURANT_ENDPOINT = '/restaurant';
const TOP_CATEGORIES_ENDPOINT = '$CATEGORIES_ENDPOINT/top';
const NEARBY_RESTAURANT_ENDPOINT =
    '$RESTAURANT_ENDPOINT/get-nearby-restaurants';
const GET_PROFILE__ENDPOINT = '/api/clients/me';

class HomeService {
  final CacheHelper _cacheHelper;

  HomeService(this._cacheHelper);

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
      final responseBody = utf8.decode(response.bodyBytes); // Decode UTF-8
      final List data = jsonDecode(responseBody);

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

  Future<HomeProfileModel> getProfile() async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$GET_PROFILE__ENDPOINT');
      final token = _cacheHelper.getSessionToken();
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await getProfile();
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);
      final userProfile = HomeProfileModel.fromJson(data);
      await _cacheHelper.cacheUserProfile(userProfile);
      return userProfile;
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la mise à jour du profil. Veuillez réessayer plus tard.",
      );
    }
  }
}
