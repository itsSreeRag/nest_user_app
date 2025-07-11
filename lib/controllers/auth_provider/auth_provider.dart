// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_helpers.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_messages.dart';
import 'package:nest_user_app/controllers/navigation_bar_provider/navigation_bar_provider.dart';
import 'package:nest_user_app/controllers/user_provider/user_provider.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/services/firebase_auth_service.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';
import 'package:nest_user_app/views/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This provider handles all user authentication-related logic
class MyAuthProviders with ChangeNotifier {
  final FirebaseAuthService authService = FirebaseAuthService();

  User? user;
  String? errorMessage;
  bool showOtpField = false;
  String? verificationId;

  // Check if user is logged in using SharedPreferences
  Future<bool> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool('isLoggedIn') ?? false;
  }

  // Save login state in SharedPreferences
  Future<void> saveUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('isLoggedIn', true);
  }

  // Sign out the user and reset the login state
  Future<void> logout(BuildContext context) async {
    await authService.signOut(); // Firebase sign out
    user = null;
    notifyListeners();

    AuthMessages.showSuccess(context, 'Logout successful');
    (await SharedPreferences.getInstance()).setBool('isLoggedIn', false);
    Provider.of<UserProvider>(listen: false, context).clearUser();
    Provider.of<NavigationBarProvider>(context,listen: false,).clearNavidationBar();

    // Navigate to login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogInPageMain()),
      (route) => false,
    );
  }

  // Sign in using Google account
  Future<bool> regUsingGoogleAcc(BuildContext context) async {
    try {
      user = await authService.signInWithGoogle();
      notifyListeners();

      if (user != null) {
        await saveUserToFirestore(context, user!);
        AuthMessages.showSuccess(context, 'Google Sign-In Successful');
        await saveUserLoggedIn();

        // Navigate to home screen
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

  // Register a new user using email and password
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

  // Log in with email and password
  Future<void> loginAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await authService.loginWithEmail(email, password);
      await saveUserLoggedIn();

      // Navigate to home screen
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

  // Send OTP to the given phone number
  void sendOTP(
    BuildContext context,
    TextEditingController phoneController,
  ) async {
    final phone = '+91${phoneController.text.trim()}';
    try {
      await authService.verifyPhone(
        phoneNumber: phone,
        // Auto verification (Android only)
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
        // If verification fails
        onVerificationFailed: (e) {
          AuthMessages.showError(context, 'Verification failed: ${e.message}');
        },
        // When OTP is sent
        onCodeSent: (id, _) {
          verificationId = id;
          showOtpField = true;
          notifyListeners();
        },
        // Timeout handler
        onCodeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      AuthMessages.showError(context, 'OTP Error: $e');
    }
  }

  // Verify the entered OTP
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

  // Send password reset email
  Future<void> resetPassword(String email) async {
    await authService.sendPasswordReset(email);
  }

  // Save user data to Firestore (if new user), or set existing user
  Future<void> saveUserToFirestore(BuildContext context, User user) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final existingUser = await userProvider.getUserById(user.uid);

    if (existingUser == null) {
      String? username;
      if (user.displayName == null) {
        if (user.email != null) {
          username = user.email!.split('@')[0]; // Extract email prefix
        } else {
          username =
              'user${user.phoneNumber!.substring(user.phoneNumber!.length - 4)}'; // Fallback username
        }
      }

      final userModel = UserModel(
        userId: user.uid,
        name: user.displayName ?? username,
        email: user.email ?? '',
        phoneNumber: user.phoneNumber ?? '',
        gender: '',
        profileImage: user.photoURL,
      );

      await userProvider.addUser(userModel); // Save new user to Firestore
    } else {
      userProvider.setCurrentUser(existingUser); // Use existing user data
    }
  }
}
