import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => auth.currentUser;

  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<User?> registerWithEmail(String email, String password) async {
    final credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<void> loginWithEmail(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendPasswordReset(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await auth.signOut();
  }

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
    );
  }

  Future<User?> verifyOtp(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential = await auth.signInWithCredential(credential);
    return userCredential.user;
  }
}
