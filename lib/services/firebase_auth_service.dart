import 'package:citracker/core/exceptions/custom_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<User?> doLogin(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw CustomException(message: "User doesn't exist");
      }
      if (!credential.user!.emailVerified) {
        throw CustomException(message: 'Please verify your email account');
      }
      User? user = credential.user;
      if (user != null) {
        return user;
      } else {
        throw CustomException(
            message:
                'This email has not been registered, please register first');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(message: 'Invalid email format');
        case 'user-disabled':
          throw CustomException(
              message: 'This user has been disabled, please contact admin');
        case 'user-not-found':
          throw CustomException(message: 'User not found');
        case 'wrong-password':
          throw CustomException(message: 'Wrong password');
        case 'too-many-requests':
          throw CustomException(
              message:
                  'Your account has been banned because too many failed login attemp, please contact admin to unbanned');
        default:
          throw CustomException(message: 'Please try again');
      }
    }
  }

  Future<UserCredential?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth == null) {
        return null;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message!);
    }
  }

  Future<User?> doRegister({
    required String username,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(username);
        return credential.user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message!);
    }
  }
}
