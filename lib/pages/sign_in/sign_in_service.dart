import 'package:citracker/common/constants/storage.dart';
import 'package:citracker/common/services/firebase_auth_service.dart';
import 'package:citracker/common/widgets/dialog/reusable_dialog.dart';
import 'package:citracker/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInService {
  BuildContext context;
  final FirebaseAuthService _authService = FirebaseAuthService();

  SignInService({required this.context});

  Future<void> doLogin(String email, String password) async {
    try {
      final credential = await _authService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        Navigator.pop(context);
        reusableDialog(context: context, msg: "User doesn't exist");
        return;
      }
      if (!credential.user!.emailVerified) {
        Navigator.pop(context);
        reusableDialog(
            context: context, msg: 'Please verify your email account');
        return;
      }
      User? user = credential.user;
      if (user != null) {
        Global.storageService
            .setString(StorageConstants.STORAGE_USER_TOKEN_KEY, user.uid);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      } else {
        Navigator.pop(context);
        reusableDialog(
            context: context,
            msg: 'User with that email is not yet registered');
        return;
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      switch (e.code) {
        case 'invalid-email':
          reusableDialog(context: context, msg: 'Invalid email format');
          break;
        case 'user-disabled':
          reusableDialog(
              context: context,
              msg: 'This user has been disabled, please contact admin');
          break;
        case 'user-not-found':
          reusableDialog(context: context, msg: 'User not found');
          break;
        case 'wrong-password':
          reusableDialog(context: context, msg: 'Wrong password');
          break;
        case 'too-many-requests':
          reusableDialog(
              context: context,
              msg:
                  'Your account has been banned because too many failed login attemp, please contact admin to unbanned');
          break;
        default:
          reusableDialog(context: context, msg: 'Please try again');
      }
    }
  }

  Future<UserCredential> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth == null) {
        Navigator.pop(context);
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _authService.auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw "Login error: ${e.message.toString()}";
    }
  }
}
