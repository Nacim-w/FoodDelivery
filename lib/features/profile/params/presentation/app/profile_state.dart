import 'package:equatable/equatable.dart';
import 'package:legy/features/profile/params/model/client_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final ClientProfileModel profile;

  const ProfileUpdated(this.profile);

  @override
  List<Object?> get props => [profile];
}

class PasswordChanged extends ProfileState {
  const PasswordChanged();

  @override
  List<Object?> get props => [];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
