// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/profile/params/model/client_profile_model.dart';

const PROFILE_UPDATE_ENDPOINT = '/api/clients/me/update';
const CHANGE_PASSWORD_ENDPOINT = '/api/auth/change-password';

class ProfileService {
  final CacheHelper _cacheHelper;

  ProfileService(this._cacheHelper);

  Future<ClientProfileModel> updateProfile(ClientProfileModel profile) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$PROFILE_UPDATE_ENDPOINT');
      final token = _cacheHelper.getSessionToken();

      final response = await http.put(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await updateProfile(profile);
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
      return ClientProfileModel.fromJson(data);
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la mise à jour du profil. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$CHANGE_PASSWORD_ENDPOINT');
      final token = _cacheHelper.getSessionToken();

      final response = await http.put(
        uri.replace(queryParameters: {'Authorization ': token}),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          );
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      // Success: no return value needed.
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors du changement de mot de passe. Veuillez réessayer plus tard.",
      );
    }
  }
}
