abstract class SignInEvent {
  const SignInEvent();
}

class EmailChanged extends SignInEvent {
  const EmailChanged(this.email);

  final String email;
}

class PasswordChanged extends SignInEvent {
  const PasswordChanged(this.password);
  final String password;
}

