// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/error_response.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/model/login_response_model.dart';

const REQUEST_MAPPING = '/api/auth';

const LOGIN_ENDPOINT = '$REQUEST_MAPPING/login';

class AuthService {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$LOGIN_ENDPOINT');

      final response = await http.post(
        uri,
        body: jsonEncode({'password': password, 'email': email}),
        headers: NetworkConstants.headers,
      );
      debugPrint('Login response: ${response.body}');
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse(message: response.body);
        throw ServerException(
          message: errorResponse.errorMessage,
        );
      }
      final data = jsonDecode(response.body);
      final userResponse = LoginResponseModel.fromJson(data);
      await sl<CacheHelper>().cacheSessionToken(data['token']);
      return userResponse;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw const ServerException(
        message:
            "Une erreur s'est produite : ce n'est pas votre faute, c'est la nôtre",
      );
    }
  }

  AuthService();

// Future<Client> register(String email, String password) async {
//   final url = Uri.parse('$baseUrl/register');
//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'email': email, 'password': password}),
//   );
//
//   if (response.statusCode == 201) {
//     final data = jsonDecode(response.body);
//     return Client.fromJson(data);
//   } else {
//     final error = jsonDecode(response.body);
//     throw Exception(error['message'] ?? 'Registration failed');
//   }
// }
}
