import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/auth/model/forgot_password_model.dart';
import 'package:legy/features/auth/model/login_response_model.dart';
import 'package:legy/features/auth/model/register_response_model.dart';
import 'package:legy/features/auth/service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authService}) : super(AuthInitial());

  final AuthService authService;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final loginResponse =
          await authService.login(email: email, password: password);
      emit(LoggedIn(loginResponse));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
  }) async {
    emit(AuthLoading());
    try {
      final registerResponse = await authService.register(
        username: username,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        address: address,
      );
      emit(Registered(registerResponse));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> sendResetCode(String email) async {
    emit(AuthLoading());
    try {
      final response = await authService.sendResetCode(email: email);
      emit(CodeSentSuccessfully(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyCode(String email, String code) async {
    emit(AuthLoading());
    try {
      final isValid =
          (await authService.verifyResetCode(email: email, code: code));
      if (isValid) {
        emit(CodeVerified(email: email, code: code));
      } else {
        emit(AuthError("Invalid verification code"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(
      String email, String code, String newPassword) async {
    emit(AuthLoading());
    try {
      final message = await authService.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      );

      emit(PasswordResetSuccess(message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
