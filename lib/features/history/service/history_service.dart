import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/history/model/history_order_models.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/history/model/report_model.dart';

class HistoryService {
  final CacheHelper cacheHelper;

  HistoryService(this.cacheHelper);

  Future<List<OrderModel>> fetchOrders() async {
    final uri = Uri.parse('${NetworkConstants.baseUrl}/api/orders/history');
    String? token = cacheHelper.getSessionToken();
    try {
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      debugPrint('HistoryService fetchOrders response: ${response.body}');
      debugPrint(
          'HistoryService fetchOrders status code: ${response.statusCode}');
      debugPrint('HistoryService fetchOrders headers: ${response.headers}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          token = cacheHelper.getSessionToken();
          final retryResponse = await http.get(
            uri,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );
          return _handleResponse(retryResponse);
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      return _handleResponse(response);
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Impossible de récupérer les commandes. Réessayez plus tard.",
      );
    }
  }

  List<OrderModel> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> contentList = decoded['content'];
      return contentList.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw ServerException(message: "Erreur serveur : ${response.body}");
    }
  }

  Future<void> sendReport(ReportModel report) async {
    final uri =
        Uri.parse('${NetworkConstants.baseUrl}/api/v1/orders/report-issue');
    String? token = cacheHelper.getSessionToken();
    print(uri);
    try {
      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(report.toJson()),
      );

      debugPrint('sendReport response: ${response.body}');
      debugPrint(' sendReport status: ${response.statusCode}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          token = cacheHelper.getSessionToken();
          final retryResponse = await http.post(
            uri,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode(report.toJson()),
          );
          _handleReportResponse(retryResponse);
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      } else {
        _handleReportResponse(response);
      }
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Impossible d'envoyer le rapport. Réessayez plus tard.",
      );
    }
  }

  void _handleReportResponse(http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw ServerException(message: "Erreur rapport : ${response.body}");
    }
  }

  Future<String> uploadReportImage(File imageFile) async {
    final uri =
        Uri.parse('${NetworkConstants.baseUrl}/api/v1/reports/upload-image');
    String? token = cacheHelper.getSessionToken();

    try {
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

      // Add the image file to the request
      final multipartFile = await http.MultipartFile.fromPath(
        'image', // Field name expected by backend
        imageFile.path,
      );
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('uploadReportImage response: ${response.body}');
      debugPrint('uploadReportImage status code: ${response.statusCode}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await uploadReportImage(imageFile);
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
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
            errorJson['error'] ?? 'Erreur lors du téléchargement de l\'image.';
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
