import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/web_socket/presentation/app/adapter/tracking_service.dart';
import 'package:legy/features/web_socket/service/tracking_service.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingService trackingService;

  TrackingCubit({required this.trackingService}) : super(const TrackingState());

  void startTracking(String orderId) {
    trackingService.onLocationReceived = (update) {
      emit(state.copyWith(location: update));
    };
    trackingService.connect(orderId);
    emit(state.copyWith(isTracking: true));
  }

  void stopTracking() {
    trackingService.disconnect();
    emit(state.copyWith(isTracking: false, location: null));
  }
}
