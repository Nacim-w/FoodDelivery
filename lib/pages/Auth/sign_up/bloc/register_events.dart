abstract class RegisterEvent {
  const RegisterEvent();
}

class UserNameEvent extends RegisterEvent {
  const UserNameEvent(this.username);
  final String username;
}

class EmailEvent extends RegisterEvent {
  const EmailEvent(this.email);
  final String email;
}

class PasswordEvent extends RegisterEvent {
  const PasswordEvent(this.password);
  final String password;
}

class RePasswordEvent extends RegisterEvent {
  const RePasswordEvent(this.repassword);
  final String repassword;
}

