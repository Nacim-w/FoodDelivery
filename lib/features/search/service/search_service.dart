// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/features/search/model/search_model.dart';

const SEARCH_ENDPOINT = '/search';

class SearchService {
  final CacheHelper _cacheHelper;

  SearchService(this._cacheHelper);

  Future<List<SearchModel>> search(String query) async {
    if (query.trim().length <= 3) {
      return [];
    }
    final token = _cacheHelper.getSessionToken();

    if (token == null) {
      throw const ForceLogoutException(
        message: "Session expirée. Veuillez vous reconnecter.",
      );
    }

    try {
      final response = await _makeSearchRequest(query, token);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body is List) {
          return body.map((item) => SearchModel.fromJson(item)).toList();
        } else {
          throw const ServerException(
            message: "Format de réponse inattendu.",
          );
        }
      }

      if (response.statusCode == 401) {
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          final newToken = _cacheHelper.getSessionToken();
          if (newToken != null) {
            final retryResponse = await _makeSearchRequest(query, newToken);
            if (retryResponse.statusCode == 200) {
              final retryBody = jsonDecode(retryResponse.body);
              if (retryBody is List) {
                return retryBody
                    .map((item) => SearchModel.fromJson(item))
                    .toList();
              }
            }
          }
        }
        throw const ForceLogoutException(
          message: "Session expirée. Veuillez vous reconnecter.",
        );
      }

      final errorJson = jsonDecode(response.body);
      final errorMessage = errorJson['error'] ?? 'Erreur inconnue.';
      throw ServerException(message: errorMessage);
    } on ForceLogoutException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la recherche. Veuillez réessayer plus tard.",
      );
    }
  }

  Future<http.Response> _makeSearchRequest(String query, String token) {
    final uri = Uri.parse('${NetworkConstants.baseUrl}$SEARCH_ENDPOINT')
        .replace(queryParameters: {'query': query});

    return http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
  }
}
