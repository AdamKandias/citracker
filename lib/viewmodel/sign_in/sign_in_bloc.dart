import 'package:citracker/services/firebase_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/storage.dart';
import '../../global.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<LoginActionEvent>(_loginHandler);
    on<GoogleLoginActionEvent>(_googleLoginHandler);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginHandler(LoginActionEvent event, Emitter<SignInState> emit) async {
    String email = state.email;
    String password = state.password;
    emit(SignInLoading(email: email, password: password));
    if (email.isEmpty && password.isEmpty) {
      emit(SignInFailed(
          message: "Email and password is empty",
          email: email,
          password: password));
      return;
    }
    if (email.isEmpty) {
      emit(SignInFailed(
          message: "Email is empty", email: email, password: password));
      return;
    }
    if (password.isEmpty) {
      emit(SignInFailed(
          message: "Password is empty", email: email, password: password));
      return;
    }
    try {
      var user = await FirebaseAuthService().doLogin(email, password);
      if (user != null) {
        emit(SignInSuccess(message: "Login Success"));
        Global.storageService
            .setString(StorageConstants.storageUserTokenKey, user.uid);
        return;
      }
      emit(SignInFailed(
          message: "Unknown error, please try again",
          email: email,
          password: password));
      return;
    } catch (e) {
      emit(SignInFailed(
          message: e.toString(), email: email, password: password));
    }
  }

  void _googleLoginHandler(
      GoogleLoginActionEvent event, Emitter<SignInState> emit) async {
    emit(GoogleSignInLoading());
    try {
      var userCredential = await FirebaseAuthService().googleSignIn();
      if (userCredential != null) {
        emit(GoogleSignInSuccess(message: "Sign in success"));
        Global.storageService.setString(
            StorageConstants.storageUserTokenKey, userCredential.user!.uid);
      } else {
        emit(GoogleSignInCancel());
      }
    } catch (e) {
      emit(GoogleSignInFailed(message: e.toString()));
    }
  }
}
