import 'package:citracker/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<UsernameEvent>(_usernameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<PasswordConfirmEvent>(_passwordConfirmEvent);
    on<RegisterActionEvent>(_registerHandler);
  }

  void _usernameEvent(UsernameEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _emailEvent(EmailEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _passwordConfirmEvent(
      PasswordConfirmEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(passwordConfirm: event.passwordConfirm));
  }

  void _registerHandler(
      RegisterActionEvent event, Emitter<RegisterState> emit) async {
    final String username = state.username;
    final String email = state.email;
    final String password = state.password;
    final String passwordConfirm = state.passwordConfirm;
    emit(RegisterLoading(
        username: username,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm));

    if (username.isEmpty) {
      emit(RegisterFailed(
          message: "Username field can't empty",
          username: username,
          email: email,
          password: password,
          passwordConfirm: passwordConfirm));
      return;
    }
    if (email.isEmpty) {
      emit(RegisterFailed(
          message: "Email field can't empty",
          username: username,
          email: email,
          password: password,
          passwordConfirm: passwordConfirm));
      return;
    }
    if (password.isEmpty) {
      emit(RegisterFailed(
          message: "Password field can't empty",
          username: username,
          email: email,
          password: password,
          passwordConfirm: passwordConfirm));
      return;
    }
    if (passwordConfirm.isEmpty || password != passwordConfirm) {
      emit(RegisterFailed(
          message: "Password confirm is not same with your password",
          username: username,
          email: email,
          password: password,
          passwordConfirm: passwordConfirm));
      return;
    }

    try {
      var credential = await FirebaseAuthService().doRegister(
          username: username,
          email: email,
          password: password,
          passwordConfirm: passwordConfirm);
      if (credential != null) {
        emit(RegisterSuccess(
            message:
                "Successfully registered, please check your email and confirm it"));
        return;
      } else {
        emit(RegisterFailed(
            message: "Register failed, please try again",
            username: username,
            email: email,
            password: password,
            passwordConfirm: passwordConfirm));
      }
    } catch (e) {
      switch (e.toString()) {
        case 'invalid-email':
          emit(RegisterFailed(
              message: "Invalid email format",
              username: username,
              email: email,
              password: password,
              passwordConfirm: passwordConfirm));
          break;
        case 'email-already-in-use':
          emit(RegisterFailed(
              message: "This email has been registered",
              username: username,
              email: email,
              password: password,
              passwordConfirm: passwordConfirm));
          break;
        case 'weak-password':
          emit(RegisterFailed(
              message: "Password is too short or weak",
              username: username,
              email: email,
              password: password,
              passwordConfirm: passwordConfirm));
          break;
        case 'operation-not-allowed':
          emit(RegisterFailed(
              message:
                  "Account with this email has been disabled, please contact admin",
              username: username,
              email: email,
              password: password,
              passwordConfirm: passwordConfirm));
          break;
        default:
          emit(RegisterFailed(
              message: "Unknown error, please try again",
              username: username,
              email: email,
              password: password,
              passwordConfirm: passwordConfirm));
      }
    }
  }
}
