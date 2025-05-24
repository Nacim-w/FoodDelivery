import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/profile/params/model/client_profile_model.dart';
import 'package:legy/features/profile/params/service/profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileService}) : super(ProfileInitial());
  final ProfileService profileService;
  Future<void> updateProfile({
    required String firstname,
    required String lastname,
    required String phoneNumber,
    required String address,
  }) async {
    emit(ProfileLoading());
    try {
      final updatedProfile = await profileService.updateProfile(
        ClientProfileModel(
          firstname: firstname,
          lastname: lastname,
          phoneNumber: phoneNumber,
          address: address,
        ),
      );
      emit(ProfileUpdated(updatedProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ProfileLoading());
    try {
      await profileService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(const PasswordChanged());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
