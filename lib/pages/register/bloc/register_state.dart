class RegisterState {
  final String username;
  final String email;
  final String password;
  final String passwordConfirm;

  RegisterState(
      {this.username = '',
      this.email = '',
      this.password = '',
      this.passwordConfirm = ''});

  RegisterState copyWith(
      {String? username,
      String? email,
      String? password,
      String? passwordConfirm}) {
    return RegisterState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm);
  }
}
