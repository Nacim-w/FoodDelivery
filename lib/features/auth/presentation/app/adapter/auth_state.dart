part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoggedIn extends AuthState {
  const LoggedIn(this.loginResponseModel);

  final LoginResponseModel loginResponseModel;

  @override
  List<Object> get props => [loginResponseModel];
}

final class Registered extends AuthState {
  const Registered(this.registerResponseModel);

  final RegisterResponseModel registerResponseModel;

  @override
  List<Object> get props => [registerResponseModel];
}

final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
