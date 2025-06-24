part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoggedIn extends AuthState {
  const LoggedIn(this.loginResponseModel);

  final LoginResponseModel loginResponseModel;

  @override
  List<Object> get props => [loginResponseModel];
}

class Registered extends AuthState {
  const Registered(this.registerResponseModel);

  final RegisterResponseModel registerResponseModel;

  @override
  List<Object> get props => [registerResponseModel];
}

class CodeSentSuccessfully extends AuthState {
  const CodeSentSuccessfully(this.forgotPasswordModel);

  final ForgotPasswordModel forgotPasswordModel;

  @override
  List<Object> get props => [forgotPasswordModel];
}

class CodeVerified extends AuthState {
  const CodeVerified({required this.email, required this.code});

  final String email;
  final String code;

  @override
  List<Object> get props => [email, code];
}

class PasswordResetSuccess extends AuthState {
  final String message;
  const PasswordResetSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class LoggedInGoogle extends AuthState {
  final Client client;
  const LoggedInGoogle(this.client);

  @override
  List<Object> get props => [client];
}
