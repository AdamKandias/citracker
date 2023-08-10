import 'package:citracker/common/constants/storage.dart';
import 'package:citracker/common/services/firebase_auth_service.dart';
import 'package:citracker/global.dart';
import 'package:flutter/material.dart';

class ProfileController {
  BuildContext context;
  ProfileController({required this.context});
  void logoutHandler() {
    Navigator.pop(context);
    Global.storageService.remove(StorageConstants.STORAGE_USER_TOKEN_KEY);
    FirebaseAuthService().logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      "sign_in",
      (route) => false,
    );
  }
}
