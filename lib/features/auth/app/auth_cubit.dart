import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legy/features/auth/app/auth_state.dart';
import 'package:legy/features/auth/service/auth_service.dart';
import 'package:legy/global.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  LoginCubit(this.authService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final loginResponse = await authService.login(email, password);

      await _secureStorage.write(
        key: 'jwt_token',
        value: loginResponse.token,
      );

      Global.authNotifier.setLoggedIn(true);

      emit(LoginSuccess(loginResponse));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt_token');
    Global.authNotifier.setLoggedIn(false);
    emit(LoginInitial());
  }
}
