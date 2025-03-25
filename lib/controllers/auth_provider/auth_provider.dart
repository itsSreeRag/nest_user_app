// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';
import 'package:nest_user_app/views/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuthProviders with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? _errorMessage;
  User? _user;
  bool showOtpField = false;
  String? verificationId;

  String? get errorMessage => _errorMessage;
  User? get user => _user;

  //-------------check user is logged in or not------------------
  Future checkUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn == null || isLoggedIn == false) {
      return false;
    } else {
      return true;
    }
  }
  // -----------save user logged in-------------

  Future saveUserLoggedIn() async {
    log('shared pref');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    log('${prefs.getBool('isLoggedIn')}');
  }

  // ----------- Registration using google account---------------

  Future<bool> regUsingGoogleAcc(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      _user = userCredential.user;
      notifyListeners();

      if (_user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.green,
            content: Text("Google Sign-In Successful"),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomeScreen()),
        );
        saveUserLoggedIn();
        return true;
      }
      return false;
    } catch (e) {
      log("Google Sign-In Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed: ${e.toString()}")),
      );
      return false;
    }
  }

  //--------------Registration Using Email---------------------

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
      _user = _auth.currentUser;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.green,
          content: Text('Account Created Successfully'),
        ),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The email is already in use.';
      } else {
        message = e.message ?? 'An unknown error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: AppColors.red, content: Text(message)),
      );

      _errorMessage = message;
      notifyListeners();
      return false;
    }
  }

  //-------------------Login Using Emial-------------------

  Future<void> loginAccount(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      log(credential.toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomeScreen()),
        (route) => false,
      );
      saveUserLoggedIn();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = 'Login failed: ${e.message}';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }

  //-------------------Log Out-------------------

  Future<void> logout(BuildContext context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _user = null;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.green,
        content: Text('LogOut successful'),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LogInPageMain()),
      (route) => false,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
  //----------------------Send OTP for Phone Authentication-------------------

  void sendOTP(BuildContext context, TextEditingController phoneNumbers) async {
    String phoneNumber = '+91${phoneNumbers.text.trim()}';
    log("Sending OTP to: $phoneNumber");

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log("Auto verification completed");
          await _auth.signInWithCredential(credential);
          _user = _auth.currentUser;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Auto verification successful!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomeScreen()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          log("Verification Failed: ${e.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          log("OTP Sent to $phoneNumber");
          this.verificationId = verificationId;
          showOtpField = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log("Auto retrieval timeout");
        },
      );
    } catch (e) {
      log("Error sending OTP: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  // ----------- Verify OTP ---------------
  Future<void> verifyOTP(
    BuildContext context,
    TextEditingController otpController,
  ) async {
    try {
      if (verificationId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("No OTP request found.")));
        return;
      }

      String otp = otpController.text.trim();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      _user = _auth.currentUser;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified Successfully!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomeScreen()),
      );
      saveUserLoggedIn();
    } on FirebaseAuthException catch (e) {
      log("OTP Verification Failed: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verification Failed: ${e.message}")),
      );
    }
  }

  //-------------forgot password------------------

  Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
