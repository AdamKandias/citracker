import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  factory FirebaseAuthService() => _instance;

  late FirebaseAuth auth;

  FirebaseAuthService._internal() {
    auth = FirebaseAuth.instance;
  }

  User? getUser() {
    return auth.currentUser!;
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
}
