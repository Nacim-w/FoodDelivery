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

final class CodeSentSuccessfully extends AuthState {
  const CodeSentSuccessfully(this.forgotPasswordModel);

  final ForgotPasswordModel forgotPasswordModel;

  @override
  List<Object> get props => [forgotPasswordModel];
}

final class CodeVerified extends AuthState {
  const CodeVerified({required this.email, required this.code});

  final String email;
  final String code;

  @override
  List<Object> get props => [email, code];
}

final class PasswordResetSuccess extends AuthState {
  final String message;
  const PasswordResetSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
