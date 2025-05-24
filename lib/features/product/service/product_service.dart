import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/product/model/product_model.dart';

class ProductService {
  ProductService();

  Future<ProductModel> getProductById(String id) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}/products/$id');

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
      return ProductModel.fromJson(data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message: "Une erreur est survenue lors du chargement du produit.",
      );
    }
  }
}
