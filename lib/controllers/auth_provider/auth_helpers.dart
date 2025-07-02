import 'package:firebase_auth/firebase_auth.dart';

class AuthHelpers {
  static String getRegisterErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password is too weak.';
      case 'email-already-in-use':
        return 'The email is already in use.';
      default:
        return e.message ?? 'An unknown error occurred.';
    }
  }

  static String getLoginErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      default:
        return 'Login failed: ${e.message}';
    }
  }
}
