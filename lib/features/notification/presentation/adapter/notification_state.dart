import 'package:equatable/equatable.dart';
import 'package:legy/features/notification/model/notification_model.dart';

class NotificationState extends Equatable {
  final List<NotificationModel>? notifications;
  final bool isLoadingNotifications;
  final String? notificationsError;
  const NotificationState({
    this.notifications,
    this.isLoadingNotifications = false,
    this.notificationsError,
  });
  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoadingNotifications,
    String? notificationsError,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoadingNotifications:
          isLoadingNotifications ?? this.isLoadingNotifications,
      notificationsError: notificationsError ?? this.notificationsError,
    );
  }

  @override
  List<Object?> get props => [
        notifications,
        isLoadingNotifications,
        notificationsError,
      ];
}
