import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/utils/network_constants.dart';
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
    final uri = Uri.parse('${NetworkConstants.baseUrl}/api/orders');
    final token = cacheHelper.getSessionToken();

    final orderBody = {
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
      "client": {
        "longitude": 0.1,
        "latitude": 0.1,
      },
      "restaurantId": restaurantId,
      "deliveryAddress": deliveryAddress,
      "paymentMethod": paymentMethod,
      "deliveryMode": "DELIVERY",
      "status": "PENDING"
    };

    final response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(orderBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      final errorJson = jsonDecode(response.body);
      final errorMessage = errorJson['error'] ?? 'Unknown error occurred';
      throw Exception('❌ Failed to place order: $errorMessage');
    }
  }
}
