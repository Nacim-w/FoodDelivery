// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:legy/core/common/app/cache_helper.dart';
import 'package:legy/core/errors/exceptions.dart';
import 'package:legy/core/service/injection/injection_container.dart';
import 'package:legy/core/utils/network_constants.dart';
import 'package:legy/features/auth/model/forgot_password_model.dart';
import 'package:legy/features/auth/model/google_response_model.dart';
import 'package:legy/features/auth/model/login_response_model.dart';
import 'package:legy/features/auth/model/register_response_model.dart';
import 'package:legy/features/profile/params/model/client_profile_model.dart';

const REQUEST_MAPPING = '/api/auth';
const USER_MAPPING = '/api/users';
const CLIENT_MAPPING = '/api/clients';
const FIREBASE_Mapping = '$REQUEST_MAPPING/firebase';
const ME_ENDPOINT = '$CLIENT_MAPPING/me';
const UPDATE_ENDPOINT = '$ME_ENDPOINT/update';
const GOOGLE_ENDPOINT = '$FIREBASE_Mapping/google';
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
      debugPrint('AuthService login response: ${response.body}');
      debugPrint('AuthService login status code: ${response.statusCode}');
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
      debugPrint('AuthService register uri: $uri');
      debugPrint(
          'AuthService register body: $username, $firstname, $lastname, $email, $password, $phoneNumber, $address');
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
          "longitude": 0.1,
          "latitude": 0.1
        }),
        headers: NetworkConstants.headers,
      );
      debugPrint('AuthService register response: ${response.body}');
      debugPrint('AuthService register status code: ${response.statusCode}');
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

  Future<ClientProfileModel> getClientProfile(String token) async {
    final uri = Uri.parse('${NetworkConstants.baseUrl}$ME_ENDPOINT');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/jso1n',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ClientProfileModel.fromJson(json);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<GoogleResponseModel?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId:
            '540049131134-67rk1psemc9l96htfmrusctrhk3vtmp7.apps.googleusercontent.com',
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('Google sign-in was canceled by the user.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      debugPrint('Google Access Token: ${googleAuth.accessToken}');
      debugPrint('Google ID Token: ${googleAuth.idToken}');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      final firebaseIdToken = await user.getIdToken();

      final client = await _loginWithFirebaseIdToken(firebaseIdToken!);
      return client;
    } on ServerException catch (e) {
      if (e.message == 'missingPhoneNumber') {
        throw ServerException(message: 'MISSING_PHONE_NUMBER');
      }
      rethrow;
    } catch (e) {
      print('Error during Google sign-in: $e');
      throw Exception("Erreur lors de la connexion avec Google.");
    }
  }

  Future<GoogleResponseModel> _loginWithFirebaseIdToken(
      String firebaseIdToken) async {
    print('firebaseIdToken: $firebaseIdToken');

    try {
      final uri = Uri.parse('${NetworkConstants.baseUrl}$GOOGLE_ENDPOINT');
      debugPrint('uri: $uri');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idToken': firebaseIdToken,
        }),
      );
      final data = jsonDecode(response.body);

      debugPrint(
          'AuthService _loginWithFirebaseIdToken response: ${response.body}');
      debugPrint(
          'AuthService _loginWithFirebaseIdToken status code: ${response.statusCode}');

      if (response.statusCode == 422 && data['missingPhoneNumber'] == true) {
        await sl<CacheHelper>().cacheSessionToken(data['token']);
        await sl<CacheHelper>().cacheRefreshToken(data['refreshToken']);
        throw const ServerException(message: 'missingPhoneNumber');
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorMessage = data['error'] ?? 'Une erreur est survenue.';
        throw ServerException(message: errorMessage.toString());
      }

      final userResponse = GoogleResponseModel.fromJson(data);
      await sl<CacheHelper>().cacheSessionToken(data['token']);
      await sl<CacheHelper>().cacheRefreshToken(data['refreshToken']);
      return userResponse;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException(
        message:
            "Une erreur s'est produite lors de la connexion avec Google. Veuillez réessayer.",
      );
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber, String token) async {
    final uri = Uri.parse('${NetworkConstants.baseUrl}$UPDATE_ENDPOINT');

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      final errorJson = jsonDecode(response.body);
      final errorMessage = errorJson['error'] ?? 'Erreur inconnue';
      throw ServerException(message: errorMessage);
    }
  }

  Future<bool> refreshToken() async {
    final refreshToken = sl<CacheHelper>().getRefreshToken();
    if (refreshToken == null) {
      await sl<CacheHelper>().resetSession();
      await sl<CacheHelper>().resetRefreshToken();
      throw const ForceLogoutException(
          message: "Session expirée, veuillez vous reconnecter.");
    }

    final uri = Uri.parse('${NetworkConstants.baseUrl}/api/auth/refresh');
    final response = await http.post(
      uri,
      headers: NetworkConstants.headers,
      body: jsonEncode({'refreshToken': refreshToken}),
    );

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
      throw const ForceLogoutException(
          message: "Session expirée, veuillez vous reconnecter.");
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
