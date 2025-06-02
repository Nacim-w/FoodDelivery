import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/product/model/product_model.dart';

class OrderService {
  final CacheHelper cacheHelper;

  OrderService(this.cacheHelper);

  Future<void> createOrder({
    required List<ProductModel> products,
    required String restaurantId,
    required String deliveryAddress,
    required String paymentMethod,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}/api/orders');
      String? token = cacheHelper.getSessionToken();
      debugPrint('uri: $uri');
      debugPrint('Token: $token');

      final orderBody = {
        "client": {
          "longitude": 10.16579,
          "latitude": 36.80611,
        },
        "restaurantId": restaurantId,
        "deliveryAddress": deliveryAddress,
        "paymentMethod": paymentMethod,
        "deliveryMode": "DELIVERY",
        "items": products.map((product) {
          return {
            "productId": product.id,
            "quantity": product.quantity,
            "categoryId": product.categoryId,
            "selectedSupplements": product.supplements
                .where((supp) => supp.quantity != null && supp.quantity! > 0)
                .map((supp) {
              return {
                "supplementId": supp.id,
                "quantity": supp.quantity!,
              };
            }).toList(),
          };
        }).toList(),
      };

      var response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(orderBody),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          token = cacheHelper.getSessionToken();
          response = await http.post(
            uri,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode(orderBody),
          );
        } else {
          throw const ForceLogoutException(
              message: "Session expirée, veuillez vous reconnecter.");
        }
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Unknown error occurred';
        throw ServerException(message: errorMessage);
      }

      // Order placed successfully
    } on ForceLogoutException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la commande. Veuillez réessayer plus tard.",
      );
    }
  }
}
