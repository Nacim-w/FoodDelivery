import 'package:equatable/equatable.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final bool success;
  final String? error;

  const OrderState({
    this.isLoading = false,
    this.success = false,
    this.error,
  });

  OrderState copyWith({
    bool? isLoading,
    bool? success,
    String? error,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, success, error];
}
