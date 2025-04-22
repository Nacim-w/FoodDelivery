import 'package:equatable/equatable.dart';
import 'package:legy/features/auth/model/Login_response_model.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponse;

  LoginSuccess(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}
