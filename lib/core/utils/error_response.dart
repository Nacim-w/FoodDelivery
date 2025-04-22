import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  const ErrorResponse({
    required this.message,
  });

  //final DateTime timestamp;
  //final int status;
  //final String error;
  final String message;

  //final String path;
  //final List<String>? errors;

  factory ErrorResponse.fromJson(dynamic json) {
    if (json is String) {
      return ErrorResponse(message: json);
    }

    if (json is Map<String, dynamic>) {
      return ErrorResponse(
        message: json['message'] as String? ?? 'Unknown error',
      );
    }

    // Fallback for unexpected payloads
    return const ErrorResponse(message: 'Unknown error');
  }

  String get errorMessage {
    var payload =
        //'$error\n'
        message.isEmpty ? "Non précisée" : message;

    // if (errors != null && errors!.isNotEmpty) {
    //   payload += '\nDétails des problèmes :';
    //   for (final error in errors!) {
    //     payload += '\n- $error';
    //   }
    //}

    return payload;
  }

  @override
  List<Object?> get props => [
        // timestamp,
        // status,
        // error,
        message,
        // path,
        // errors
      ];
}
