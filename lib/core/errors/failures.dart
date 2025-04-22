import 'package:equatable/equatable.dart';

import 'exceptions.dart' show CacheException, ServerException;

sealed class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  String get errorMessage => 'Erreur: $message';

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  ServerFailure.fromException(ServerException e)
      : this(
          message: e.message,
        );
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message}) : super();

  CacheFailure.fromException(CacheException e) : this(message: e.message);
}
