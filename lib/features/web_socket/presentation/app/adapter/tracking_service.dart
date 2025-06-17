// tracking_state.dart
import 'package:legy/features/web_socket/model/location.dart';

class TrackingState {
  final bool isTracking;
  final LocationUpdateModel? location;

  const TrackingState({
    this.isTracking = false,
    this.location,
  });

  TrackingState copyWith({
    bool? isTracking,
    LocationUpdateModel? location,
  }) {
    return TrackingState(
      isTracking: isTracking ?? this.isTracking,
      location: location ?? this.location,
    );
  }
}
