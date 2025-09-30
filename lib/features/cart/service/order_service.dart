import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/product/model/product_model.dart';

class OrderService {
  final CacheHelper cacheHelper;

  OrderService(this.cacheHelper);

  Future<String> createOrder({
    required List<ProductModel> products,
    required String restaurantId,
    required String deliveryAddress,
    required String paymentMethod,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}/api/orders');
      String? token = cacheHelper.getSessionToken();
      debugPrint('PLACE ORDER Token: $token');
      debugPrint('PLACE ORDER uri : $uri ');

      final orderBody = {
        "client": {
          "longitude": latitude,
          "latitude": longitude,
        },
        "restaurantId": '685bfed80b9cc63c8a37f11f', // keep hardcoded
        "deliveryAddress": deliveryAddress,
        "paymentMethod": paymentMethod,
        "deliveryMode": "DELIVERY",
        "items": products.map((product) {
          return {
            "productId": '686e3fe3d1a00756b7316976', // keep hardcoded
            "quantity": 2, // keep hardcoded
            /*"selectedSupplements": product.supplements.map((supplement) {
              return {
                "supplementId": supplement.id,
                "supplementName": supplement.name,
                "quantity": supplement.quantity,
              };
            }).toList(),*/
          };
        }).toList(),
      };
      debugPrint('Order Body: ${jsonEncode(orderBody)}');
      var response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(orderBody),
      );

      debugPrint('place order Response status: ${response.statusCode}');
      debugPrint('ORDER ID: ${response.body}');

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

      if (response.statusCode == 400) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['message'] ?? '';

        debugPrint('Parsed 400 message: $errorMessage');

        if (errorMessage
            .toLowerCase()
            .contains('already have an active order')) {
          throw const ActiveOrderAlreadyExistsException(
            message: "Vous avez déjà une commande en cours.",
          );
        }

        throw ServerException(message: errorMessage);
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Unknown error occurred';
        throw ServerException(message: errorMessage);
      }

      // ✅ Order placed successfully
      final isJson = response.headers[HttpHeaders.contentTypeHeader]
              ?.contains('application/json') ??
          false;

      String orderId;
      if (isJson) {
        final responseJson = jsonDecode(response.body);
        orderId = responseJson['orderId'];
        debugPrint('✅ Order placed successfully. ID: $orderId');
      } else {
        orderId = response.body.trim();
        debugPrint('✅ Order placed successfully. ID: $orderId');
      }

      // 🔔 Connect to WebSocket for order updates
      final profile = cacheHelper.getCachedUserProfile();
      debugPrint('Cached Profile: ${profile?.id}');
      await sl<CacheHelper>().cacheLastActiveOrderId(orderId);
      return orderId;
    } on ForceLogoutException {
      rethrow;
    } catch (e) {
      if (e is ActiveOrderAlreadyExistsException) rethrow;
      if (e is ForceLogoutException) rethrow;
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la commande. Veuillez réessayer plus tard.",
      );
    }
  }
}
