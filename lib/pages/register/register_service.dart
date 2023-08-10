import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterService {
  final BuildContext context;

  RegisterService({required this.context});
  void doRegister({
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        Navigator.pop(context);
        reusableDialog(
            context: context,
            msg:
                'An email has been sent to your email account, please do verification',
            backgroundColor: Colors.green);
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(username);
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          Navigator.pop(context);
          reusableDialog(context: context, msg: 'Invalid email format');
          break;
        case 'email-already-in-use':
          Navigator.pop(context);
          reusableDialog(
              context: context, msg: 'This email has been registered');
          break;
        case 'weak-password':
          Navigator.pop(context);
          reusableDialog(
              context: context, msg: 'Password is too short or weak');
          break;
        case 'operation-not-allowed':
          Navigator.pop(context);
          reusableDialog(
              context: context,
              msg:
                  'Account with this email has been disabled, please contact admin');
          break;
        default:
          Navigator.pop(context);
          reusableDialog(
              context: context, msg: 'Unknown error, please contact admin');
      }
    }
  }
}
