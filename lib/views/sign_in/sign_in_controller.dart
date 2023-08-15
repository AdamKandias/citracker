// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../core/constants/storage.dart';
// import '../../core/widgets/dialog/loading_dialog.dart';
// import '../../core/widgets/dialog/reusable_dialog.dart';
// import '../../global.dart';
// import '../../viewmodel/sign_in/sign_in_bloc.dart';
// import 'sign_in_service.dart';

// class SignInController {
//   final BuildContext context;
//   SignInController({required this.context});

//   Future<void> handleSignIn() async {
    
//   }

//   Future<void> handleGoogleSignIn() async {
//     loadingDialog(context: context);
//     try {
//       final userCredential =
//           await SignInService(context: context).googleSignIn();
//       Navigator.pop(context);
//       Global.storageService.setString(
//           StorageConstants.STORAGE_USER_TOKEN_KEY, userCredential.user!.uid);
//       Navigator.pushNamedAndRemoveUntil(
//           context, 'application', (route) => false);
//       return;
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);
//       reusableDialog(context: context, msg: "Error, ${e.message.toString()}");
//       return;
//     }
//   }
// }
