import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/pages/profile/profile_settings/blocs/profile_settings_events.dart';
import 'package:testing/pages/profile/profile_settings/blocs/profile_settings_states.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvents, ProfileSettingsStates> {
  ProfileSettingsBloc() : super(const ProfileSettingsStates()) {
    on<TriggerProfileSettings>((event, emit) {
      emit(ProfileSettingsStates(index: event.index));
    });
  }
}
