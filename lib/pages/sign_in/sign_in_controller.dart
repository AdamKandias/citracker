import 'package:citracker/common/constants/storage.dart';
import 'package:citracker/common/widgets/dialog/loading_dialog.dart';
import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:citracker/global.dart';
import 'package:citracker/pages/sign_in/sign_in_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_bloc.dart';

class SignInController {
  final BuildContext context;
  SignInController({required this.context});

  Future<void> handleSignIn() async {
    final state = context.read<SignInBloc>().state;
    String email = state.email;
    String password = state.password;
    if (email.isEmpty && password.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Email and password is empty");
      return;
    }
    if (email.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Email is empty");
      return;
    }
    if (password.isEmpty) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Password is empty");
      return;
    }
    SignInService(context: context).doLogin(email, password);
  }

  Future<void> handleGoogleSignIn() async {
    loadingDialog(context: context);
    try {
      final userCredential =
          await SignInService(context: context).googleSignIn();
      Navigator.pop(context);
      Global.storageService.setString(
          StorageConstants.STORAGE_USER_TOKEN_KEY, userCredential.user!.uid);
      Navigator.pushNamedAndRemoveUntil(
          context, 'application', (route) => false);
      return;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      reusableDialog(context: context, msg: "Error, ${e.message.toString()}");
      return;
    }
  }
}
