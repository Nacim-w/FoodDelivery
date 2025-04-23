// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/error_response.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/model/login_response_model.dart';
import 'package:legy/features/auth/model/register_response_model.dart';

const REQUEST_MAPPING = '/api/auth';
const USER_MAPPING = '/api/users';
const LOGIN_ENDPOINT = '$REQUEST_MAPPING/login';
const REGISTER_ENDPOINT = '$USER_MAPPING/register-client';

class AuthService {
  AuthService();

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
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite : ce n'est pas votre faute, c'est la nôtre",
      );
    }
  }

  Future<RegisterResponseModel> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$REGISTER_ENDPOINT');

      final response = await http.post(
        uri,
        body: jsonEncode({
          'username': username,
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'address': address,
        }),
        headers: NetworkConstants.headers,
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        final errorResponse = ErrorResponse(message: response.body);
        throw ServerException(
          message: errorResponse.errorMessage,
        );
      }

      final data = jsonDecode(response.body);
      final userResponse = RegisterResponseModel.fromJson(data);
      return userResponse;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de l'inscription. Veuillez réessayer plus tard.",
      );
    }
  }
}
