import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/notification/model/notification_model.dart';

class NotificationService {
  static const String _scope = "client";
  final CacheHelper _cacheHelper;

  NotificationService(this._cacheHelper);

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final token = _cacheHelper.getSessionToken();
      final profile = _cacheHelper.getCachedUserProfile();
      final uri = Uri.parse(
          "${NetworkConstants.baseUrl}/api/notifications/$_scope/${profile?.id}");

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await getNotifications();
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      // ✅ Return empty list if no content
      if (response.statusCode == 204 || response.body.trim().isEmpty) {
        return [];
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ??
            'Erreur lors de la récupération des notifications.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body.trim());

      if (data is List) {
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } on TokenExpiredException {
      rethrow;
    } catch (e, stackTrace) {
      debugPrint("NotificationService error: $e");
      debugPrint("StackTrace: $stackTrace");
      throw const ServerException(
        message:
            "Une erreur est survenue lors de la récupération des notifications.",
      );
    }
  }
}
