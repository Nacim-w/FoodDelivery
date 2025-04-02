import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/pages/dashboard/bloc/dashboard_events.dart';
import 'package:testing/pages/dashboard/bloc/dashboard_states.dart';

class DashboardBloc extends Bloc<DashboardEvents, DashboardStates> {
  DashboardBloc() : super(const DashboardStates()) {
    on<TriggerDashboard>((event, emit) {
      emit(DashboardStates(index: event.index));
    });
  }
}
