import 'package:testing/pages/home/bloc/home_events.dart';
import 'package:testing/pages/home/bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlocs extends Bloc<HomeEvents, HomeStates> {
  HomeBlocs() : super(HomeStates()) {
    on<TriggerHome>(_triggerHome);
  }
  _triggerHome(HomeEvents event, Emitter<HomeStates> emit) {
    emit(HomeStates());
  }
}
