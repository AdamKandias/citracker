import 'package:citracker/pages/register/bloc/register_event.dart';
import 'package:citracker/pages/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<UsernameEvent>(_usernameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<PasswordConfirmEvent>(_passwordConfirmEvent);
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
}
