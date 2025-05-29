import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/history/model/history_order_models.dart';
import 'package:legy/features/auth/service/auth_service.dart';

class HistoryService {
  final CacheHelper cacheHelper;

  HistoryService(this.cacheHelper);

  Future<List<OrderModel>> fetchOrders() async {
    final uri = Uri.parse('${NetworkConstants.baseUrl}/api/orders/history');
    String? token = cacheHelper.getSessionToken();
    debugPrint('Fetching orders with token: $token');
    debugPrint('Request URI: $uri');
    try {
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
}
