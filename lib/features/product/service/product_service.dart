import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/product/model/product_model.dart';

const PRODUCT_ENDPOINT = '/products';

class ProductService {
  final CacheHelper _cacheHelper;

  ProductService(this._cacheHelper);

  Future<ProductModel> getProductById(String id) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}$PRODUCT_ENDPOINT/get-product-by-id/$id');

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

  Future<bool> isProductFavorite(String productId) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}/favorites/products/$productId/is-favorite');
      final token = _cacheHelper.getSessionToken();

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await isProductFavorite(productId);
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage =
            errorJson['error'] ?? 'Erreur lors du chargement du statut favori.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);
      return data['isFavorite'] == true;
    } on TokenExpiredException {
      rethrow;
    } catch (_) {
      throw const ServerException(
        message: "Impossible de vérifier si le produit est en favori.",
      );
    }
  }

  Future<void> addFavorite({
    required String productId,
  }) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}/favorites/products/$productId');
      final token = _cacheHelper.getSessionToken();

      final response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await addFavorite(productId: productId);
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage =
            errorJson['error'] ?? 'Une erreur est survenue (add favorite).';
        throw ServerException(message: errorMessage);
      }

      // Success: no return value needed.
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de l'ajout aux favoris. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<void> removeFavorite({
    required String productId,
  }) async {
    try {
      final uri = Uri.parse(
          '${NetworkConstants.baseUrl}/favorites/products/$productId');
      final token = _cacheHelper.getSessionToken();

      final response = await http.delete(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await removeFavorite(productId: productId);
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage =
            errorJson['error'] ?? 'Une erreur est survenue (remove favorite).';
        throw ServerException(message: errorMessage);
      }
      // Success: no return value needed.
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la suppression des favoris. Veuillez réessayer plus tard.",
      );
    }
  }
}
