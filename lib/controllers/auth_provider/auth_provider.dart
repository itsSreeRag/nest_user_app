// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_helpers.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_messages.dart';
import 'package:nest_user_app/controllers/profile_provider/user_provider.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';
import 'package:nest_user_app/views/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuthProviders with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? errorMessage;
  User? user;
  bool showOtpField = false;
  String? verificationId;

  Future<bool> checkUserLogin() async {
    final sharedpref = await SharedPreferences.getInstance();
    final result = sharedpref.getBool('isLoggedIn') ?? false;
    return result;
  }

  Future<void> saveUserLoggedIn() async {
    final sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool('isLoggedIn', true);
  }


  Future<void> logout(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    user = null;
    notifyListeners();
    AuthMessages.showSuccess(context, 'LogOut successful');

    (await SharedPreferences.getInstance()).setBool('isLoggedIn', false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogInPageMain()),
      (route) => false,
    );
  }

  Future<bool> regUsingGoogleAcc(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;
      notifyListeners();

      if (user != null) {
        await _saveUserToFirestore(context, user!);
        AuthMessages.showSuccess(context, 'Google Sign-In Successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
        saveUserLoggedIn();
        return true;
      }
      return false;
    } catch (e) {
      AuthMessages.showError(context, 'Google Sign-In Failed: $e');
      return false;
    }
  }

  Future<bool> createAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = _auth.currentUser;
      notifyListeners();

      if (user != null) {
        await _saveUserToFirestore(context, user!);
        AuthMessages.showSuccess(context, 'Account Created Successfully');
      }

      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = AuthHelpers.getRegisterErrorMessage(e);
      notifyListeners();
      AuthMessages.showError(context, errorMessage!);
      return false;
    }
  }

  Future<void> loginAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        (route) => false,
      );
      saveUserLoggedIn();
    } on FirebaseAuthException catch (e) {
      AuthMessages.showError(context, AuthHelpers.getLoginErrorMessage(e));
    } catch (_) {
      AuthMessages.showError(context, 'An unexpected error occurred.');
    }
  }

  void sendOTP(
    BuildContext context,
    TextEditingController phoneController,
  ) async {
    final phone = '+91${phoneController.text.trim()}';
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
          user = _auth.currentUser;
          notifyListeners();
          AuthMessages.showSuccess(context, 'Auto verification successful!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyNavigationBar()),
          );
        },
        verificationFailed:
            (e) => AuthMessages.showError(
              context,
              'Verification failed: ${e.message}',
            ),
        codeSent: (id, _) {
          verificationId = id;
          showOtpField = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      AuthMessages.showError(context, 'Error: $e');
    }
  }

  Future<void> verifyOTP(
    BuildContext context,
    TextEditingController otpController,
  ) async {
    try {
      if (verificationId == null) {
        AuthMessages.showError(context, 'No OTP request found.');
        return;
      }

      final otp = otpController.text.trim();
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      user = _auth.currentUser;
      notifyListeners();

      if (user != null) {
        await _saveUserToFirestore(context, user!);
        AuthMessages.showSuccess(context, 'OTP Verified Successfully!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
        saveUserLoggedIn();
      }
    } on FirebaseAuthException catch (e) {
      AuthMessages.showError(context, 'OTP Verification Failed: ${e.message}');
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> _saveUserToFirestore(BuildContext context, User user) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Check if user already exists in Firestore
    final existingUser = await userProvider.getUserById(user.uid);

    if (existingUser == null) {
      final userModel = UserModel(
        userId: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        phoneNumber: user.phoneNumber ?? '',
        gender: '',
        profileImage: user.photoURL,
      );

      await userProvider.addUser(userModel);
    } else {
      userProvider.setCurrentUser(existingUser);
    }
  }
}
