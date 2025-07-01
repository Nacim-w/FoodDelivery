import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/order_details/model/order_details_model.dart';

class OrderDetailsService {
  const OrderDetailsService();

  Future<OrderDetailsModel> fetchOrderDetails(String orderId) async {
    try {
      final token = sl<CacheHelper>().getSessionToken();
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}/api/orders/$orderId/details');
      debugPrint("Fetching order details for ID: $orderId");
      debugPrint("Using token: $token");
      debugPrint("Request URI: $uri");
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
      debugPrint("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return OrderDetailsModel.fromJson(decoded);
      } else {
        throw ServerException(message: "Erreur serveur : ${response.body}");
      }
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Impossible de récupérer les détails de la commande.",
      );
    }
  }
}
