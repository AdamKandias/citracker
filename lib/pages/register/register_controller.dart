import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:citracker/pages/register/bloc/register_bloc.dart';
import 'package:citracker/pages/register/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController {
  final BuildContext context;
  RegisterController({required this.context});

  handleRegister() {
    final state = context.read<RegisterBloc>().state;
    final String username = state.username;
    final String email = state.email;
    final String password = state.password;
    final String passwordConfirm = state.passwordConfirm;

    if (username.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Username field can't empty");
      return;
    }
    if (email.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Email field can't empty");
      return;
    }
    if (password.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Password field can't empty");
      return;
    }
    if (passwordConfirm.isEmpty || password != passwordConfirm) {
      Navigator.pop(context);
      reusableDialog(
          context: context,
          msg: "Password confirm is not same with your password");
      return;
    }
    RegisterService(context: context).doRegister(
        username: username,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm);
  }
}
