import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class TokenExpiredException extends Equatable implements Exception {
  const TokenExpiredException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ForceLogoutException extends Equatable implements Exception {
  const ForceLogoutException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
