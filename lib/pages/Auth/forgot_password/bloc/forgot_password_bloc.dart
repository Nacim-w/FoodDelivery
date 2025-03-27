import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/pages/auth/forgot_password/bloc/forgot_password_events.dart';
import 'package:testing/pages/auth/forgot_password/bloc/forgot_password_states.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvents, ForgotPasswordStates> {
  ForgotPasswordBloc() : super(ForgotPasswordStates()) {
    on<TriggerForgotPassword>(_triggerForgotPassword);
  }
  _triggerForgotPassword(
      ForgotPasswordEvents event, Emitter<ForgotPasswordStates> emit) {
    emit(ForgotPasswordStates());
  }
}
