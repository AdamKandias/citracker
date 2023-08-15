class SignInState {
  final String email;
  final String password;

  SignInState({this.email = '', this.password = ''});

  SignInState copyWith({String? email, String? password}) {
    return SignInState(
        email: email ?? this.email, password: password ?? this.password);
  }
}

class SignInLoading extends SignInState {
  SignInLoading({required super.email, required super.password});
}

class SignInFailed extends SignInState {
  final String message;

  SignInFailed(
      {required this.message, required super.email, required super.password});
}

class SignInSuccess extends SignInState {
  final String message;

  SignInSuccess({required this.message});
}

class GoogleSignInLoading extends SignInState {}

class GoogleSignInCancel extends SignInState {}

class GoogleSignInFailed extends SignInState {
  final String message;

  GoogleSignInFailed({required this.message});
}

class GoogleSignInSuccess extends SignInState {
  final String message;

  GoogleSignInSuccess({required this.message});
}
