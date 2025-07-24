import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/notification/presentation/adapter/notification_state.dart';
import 'package:legy/features/notification/service/notification_service.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService notificationService;

  NotificationCubit({required this.notificationService})
      : super(const NotificationState());

  Future<void> fetchNotifications() async {
    emit(state.copyWith(
      isLoadingNotifications: true,
      notificationsError: null,
    ));

    try {
      final notifications = await notificationService.getNotifications();
      emit(state.copyWith(
        notifications: notifications,
        isLoadingNotifications: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingNotifications: false,
        notificationsError: e.toString(),
      ));
    }
  }
}
