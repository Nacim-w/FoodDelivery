abstract class ForgotPasswordEvents {}

class TriggerForgotPassword extends ForgotPasswordEvents {
  final String email;
  TriggerForgotPassword({required this.email});
}
