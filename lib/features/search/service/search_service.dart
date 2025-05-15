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
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$SEARCH_ENDPOINT');
      final token = _cacheHelper.getSessionToken();
      final response = await http.get(
        uri.replace(queryParameters: {'query': query}),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode == 401) {
        // Token expired, try refreshing
        final refreshed = await AuthService().refreshToken();
        if (refreshed) {
          return await search(query); // retry
        } else {
          throw const TokenExpiredException(message: "Session expirée.");
        }
      }

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body) as List;
      final searchResults =
          data.map((item) => SearchModel.fromJson(item)).toList();
      return searchResults;
    } on TokenExpiredException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la recherche. Veuillez réessayer plus tard.",
      );
    }
  }
}
