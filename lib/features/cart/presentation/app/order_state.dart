import 'package:equatable/equatable.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final bool success;
  final String? error;

  final String selectedLocationName;
  final double? selectedLatitude;
  final double? selectedLongitude;

  const OrderState({
    this.isLoading = false,
    this.success = false,
    this.error,
    this.selectedLocationName = 'aucun',
    this.selectedLatitude,
    this.selectedLongitude,
  });

  OrderState copyWith({
    bool? isLoading,
    bool? success,
    String? error,
    String? selectedLocationName,
    double? selectedLatitude,
    double? selectedLongitude,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error ?? this.error,
      selectedLocationName: selectedLocationName ?? this.selectedLocationName,
      selectedLatitude: selectedLatitude ?? this.selectedLatitude,
      selectedLongitude: selectedLongitude ?? this.selectedLongitude,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        success,
        error,
        selectedLocationName,
        selectedLatitude,
        selectedLongitude,
      ];
}
