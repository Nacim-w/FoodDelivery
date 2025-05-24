// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/model/forgot_password_model.dart';
import 'package:legy/features/auth/model/login_response_model.dart';
import 'package:legy/features/auth/model/register_response_model.dart';

const REQUEST_MAPPING = '/api/auth';
const USER_MAPPING = '/api/users';
const LOGIN_ENDPOINT = '$REQUEST_MAPPING/login';
const REGISTER_ENDPOINT = '$USER_MAPPING/register-client';
const FORGOT_PASSWORD_ENDPOINT = '$REQUEST_MAPPING/request-reset';
const VERIFY_RESET_CODE_ENDPOINT = '$REQUEST_MAPPING/verify-reset-code';
const RESET_PASSWORD_ENDPOINT = '$REQUEST_MAPPING/reset-password';

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
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }
      final data = jsonDecode(response.body);
      final userResponse = LoginResponseModel.fromJson(data);
      await sl<CacheHelper>().cacheSessionToken(data['token']);
      await sl<CacheHelper>().cacheRefreshToken(data['refreshToken']);

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
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(
          message: errorMessage.errorMessage,
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

  Future<bool> refreshToken() async {
    final refreshToken = sl<CacheHelper>().getRefreshToken();
    if (refreshToken == null) return false;

    final uri = Uri.parse('${NetworkConstants.baseUrl}/api/auth/refresh');
    final response = await http.post(
      uri,
      headers: NetworkConstants.headers,
      body: jsonEncode({'refreshToken': refreshToken}),
    );
    debugPrint('Refresh Token Response: ${response.body}');
    debugPrint('Refresh Token Response: refreshToken: $refreshToken');
    debugPrint('Refresh Token Response: statusCode: ${response.statusCode}');
    debugPrint('Refresh Token Response: headers: ${response.headers}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await sl<CacheHelper>().cacheSessionToken(data['token']);
      if (data.containsKey('refreshToken')) {
        await sl<CacheHelper>().cacheRefreshToken(data['refreshToken']);
      }
      return true;
    } else {
      await sl<CacheHelper>().resetSession();
      await sl<CacheHelper>().resetRefreshToken();
      return false;
    }
  }

  Future<ForgotPasswordModel> sendResetCode({
    required String email,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$FORGOT_PASSWORD_ENDPOINT');
      final response = await http.post(
        uri,
        body: jsonEncode({'email': email, 'channel': 'email'}),
        headers: NetworkConstants.headers,
      );
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }
      final data = jsonDecode(response.body);
      final userResponse = ForgotPasswordModel.fromJson(data);
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

  Future<bool> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$VERIFY_RESET_CODE_ENDPOINT');
      final response = await http.post(
        uri,
        body: jsonEncode({'email': email, 'code': code}),
        headers: NetworkConstants.headers,
      );
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }

      final data = jsonDecode(response.body);

      return data['valid'] as bool;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite : ce n'est pas votre faute, c'est la nôtre",
      );
    }
  }

  Future<String> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final uri =
          Uri.parse('${NetworkConstants.baseUrl}$RESET_PASSWORD_ENDPOINT');
      final response = await http.post(
        uri,
        body: jsonEncode({
          "email": email,
          "code": code,
          "newPassword": newPassword,
        }),
        headers: NetworkConstants.headers,
      );

      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        final errorMessage = errorJson['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage);
      }
      final data = jsonDecode(response.body);
      return data['message'];
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite : ce n'est pas votre faute, c'est la nôtre",
      );
    }
  }
}
