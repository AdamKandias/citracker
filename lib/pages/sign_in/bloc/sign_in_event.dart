import 'package:flutter/material.dart';

abstract class SignInEvent {}

class EmailEvent extends SignInEvent {
  final String email;
  EmailEvent({required this.email});
}

class PasswordEvent extends SignInEvent {
  final String password;
  PasswordEvent({required this.password});
}

class LoginActionEvent extends SignInEvent {
  BuildContext context;

  LoginActionEvent({required this.context});
}
