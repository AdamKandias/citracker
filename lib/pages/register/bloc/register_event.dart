abstract class RegisterEvent {}

class UsernameEvent extends RegisterEvent {
  final String username;

  UsernameEvent({required this.username});
}

class EmailEvent extends RegisterEvent {
  final String email;

  EmailEvent({required this.email});
}

class PasswordEvent extends RegisterEvent {
  final String password;

  PasswordEvent({required this.password});
}

class PasswordConfirmEvent extends RegisterEvent {
  final String passwordConfirm;

  PasswordConfirmEvent({required this.passwordConfirm});
}
