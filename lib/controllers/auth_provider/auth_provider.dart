// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_helpers.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_messages.dart';
import 'package:nest_user_app/controllers/profile_provider/user_provider.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/services/firebase_auth_service.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';
import 'package:nest_user_app/views/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuthProviders with ChangeNotifier {
  final FirebaseAuthService authService = FirebaseAuthService();

  User? user;
  String? errorMessage;
  bool showOtpField = false;
  String? verificationId;

  Future<bool> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('isLoggedIn', true);
  }

  Future<void> logout(BuildContext context) async {
    await authService.signOut();
    user = null;
    notifyListeners();

    AuthMessages.showSuccess(context, 'Logout successful');
    (await SharedPreferences.getInstance()).setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogInPageMain()),
      (route) => false,
    );
  }

  Future<bool> regUsingGoogleAcc(BuildContext context) async {
    try {
      user = await authService.signInWithGoogle();
      notifyListeners();

      if (user != null) {
        await saveUserToFirestore(context, user!);
        AuthMessages.showSuccess(context, 'Google Sign-In Successful');
        await saveUserLoggedIn();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
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
      user = await authService.registerWithEmail(email, password);
      notifyListeners();

      if (user != null) {
        await saveUserToFirestore(context, user!);
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
      await authService.loginWithEmail(email, password);
      await saveUserLoggedIn();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        (route) => false,
      );
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
      await authService.verifyPhone(
        phoneNumber: phone,
        onVerificationCompleted: (credential) async {
          final userCredential = await FirebaseAuth.instance
              .signInWithCredential(credential);
          user = userCredential.user;
          notifyListeners();

          AuthMessages.showSuccess(context, 'Auto verification successful!');
          await saveUserLoggedIn();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyNavigationBar()),
          );
        },
        onVerificationFailed: (e) {
          AuthMessages.showError(context, 'Verification failed: ${e.message}');
        },
        onCodeSent: (id, _) {
          verificationId = id;
          showOtpField = true;
          notifyListeners();
        },
        onCodeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      AuthMessages.showError(context, 'OTP Error: $e');
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
      user = await authService.verifyOtp(verificationId!, otp);
      notifyListeners();

      if (user != null) {
        await saveUserToFirestore(context, user!);
        AuthMessages.showSuccess(context, 'OTP Verified Successfully!');
        await saveUserLoggedIn();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
      }
    } on FirebaseAuthException catch (e) {
      AuthMessages.showError(context, 'OTP Verification Failed: ${e.message}');
    }
  }

  Future<void> resetPassword(String email) async {
    await authService.sendPasswordReset(email);
  }

  Future<void> saveUserToFirestore(BuildContext context, User user) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
