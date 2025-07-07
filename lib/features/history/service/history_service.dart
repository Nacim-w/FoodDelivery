import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/history/model/history_order_models.dart';
import 'package:legy/features/history/model/report_model.dart';
import 'package:legy/features/auth/service/auth_service.dart';

class HistoryService {
  const HistoryService();

  Future<List<OrderModel>> fetchOrders() async {
    try {
      final token = sl<CacheHelper>().getSessionToken();
      final uri = Uri.parse('${NetworkConstants.baseUrl}/api/orders/history');

      var response = await http.get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (!refreshed) {
          throw const TokenExpiredException(message: "Session expirée.");
        }

        final newToken = sl<CacheHelper>().getSessionToken();
        response = await http.get(uri, headers: {
          HttpHeaders.authorizationHeader: 'Bearer $newToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> contentList = decoded['content'];
        return contentList.map((json) => OrderModel.fromJson(json)).toList();
      } else {
        throw ServerException(message: "Erreur serveur : ${response.body}");
      }
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Impossible de récupérer les commandes. Réessayez plus tard.",
      );
    }
  }

  Future<void> sendReport(ReportModel report) async {
    try {
      final token = sl<CacheHelper>().getSessionToken();
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}/api/v1/orders/report-issue');

      var response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(report.toJson()),
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (!refreshed) {
          throw const TokenExpiredException(message: "Session expirée.");
        }
        debugPrint(response.body);
        final newToken = sl<CacheHelper>().getSessionToken();
        response = await http.post(
          uri,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $newToken',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(report.toJson()),
        );
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(message: "Erreur rapport : ${response.body}");
      }
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Impossible d'envoyer le rapport. Réessayez plus tard.",
      );
    }
  }

  Future<String> uploadReportImage(File imageFile) async {
    try {
      final token = sl<CacheHelper>().getSessionToken();
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}/api/v1/orders/upload-attachment');

      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
      debugPrint('Uploading image: ${imageFile.path}');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint('Image upload response: ${response.body}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (!refreshed) {
          throw const TokenExpiredException(message: "Session expirée.");
        }
        return await uploadReportImage(imageFile);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final imageUrl = data['imageUrl'] ?? data['url'] ?? '';
        if (imageUrl.isEmpty) {
          throw const ServerException(
            message: "URL d'image non retournée par le serveur.",
          );
        }
        return imageUrl;
      } else {
        final errorJson = jsonDecode(response.body);
        final errorMessage =
            errorJson['error'] ?? "Erreur lors du téléchargement de l'image.";
        throw ServerException(message: errorMessage);
      }
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Impossible de télécharger l'image. Réessayez plus tard.",
      );
    }
  }
}
