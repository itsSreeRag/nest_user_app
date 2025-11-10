// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_helpers.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_messages.dart';
import 'package:nest_user_app/controllers/booking_provider/booking_provider.dart';
import 'package:nest_user_app/controllers/favorite_provider/favorite_provider.dart';
import 'package:nest_user_app/controllers/navigation_bar_provider/navigation_bar_provider.dart';
import 'package:nest_user_app/controllers/user_provider/user_provider.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/services/firebase_auth_service.dart';
import 'package:nest_user_app/views/auth/signin_page/signin_page_main.dart';
import 'package:nest_user_app/views/auth/signin_page/widgets/otp_bottom_sheet/otp_bottom_sheet.dart';
import 'package:nest_user_app/views/navigation_bar/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuthProviders with ChangeNotifier {
  final FirebaseAuthService authService = FirebaseAuthService();

  User? user;
  String? errorMessage;
  bool showOtpField = false;
  String? verificationId;
  bool isLoading = false;

  bool isLoadingPhone=false;

  

  String _countryCode = '+91';
  TextEditingController phoneNumberController = TextEditingController();

  String get countryCode => _countryCode;
  // String get phoneNumber => _phoneNumber;

  void updateCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

   void setLoadingPhone(bool value) {
    isLoadingPhone = value;
    notifyListeners();
  }

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

  Future<void> logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final navProvider = Provider.of<NavigationBarProvider>(
      context,
      listen: false,
    );
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );
    final favProvider = Provider.of<FavoriteProvider>(context, listen: false);

    await authService.signOut();

    user = null;
    notifyListeners();

    userProvider.clearUser();
    navProvider.clearNavidationBar();
    bookingProvider.clearBooking();
    favProvider.clearSaved();

    AuthMessages.showSuccess(context, 'Logout successful');
    (await SharedPreferences.getInstance()).setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInPageMain()),
      (route) => false,
    );
  }

  // Sign in using Google account
  Future<bool> regUsingGoogleAcc(BuildContext context) async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  // Register a new user using email and password
  Future<bool> createAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  // Log in with email and password
  Future<void> loginAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

  // Send OTP to the given phone number
void sendOTP(BuildContext context) async {
  final phone = '$_countryCode${phoneNumberController.text.trim()}';
  setLoadingPhone(true); // Set loading to true when starting
  
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
        setLoading(false); //  Stop loading

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
      },
      // If verification fails
      onVerificationFailed: (e) {
        setLoading(false); //  Stop loading on failure
        AuthMessages.showError(context, 'Verification failed: ${e.message}');
      },
      // When OTP is sent - Show Bottom Sheet
      onCodeSent: (id, _) {
        verificationId = id;
        showOtpField = true;
        setLoading(false); //  Stop loading when OTP is sent
        notifyListeners();

        // Show OTP Bottom Sheet
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          builder: (context) => OtpBottomSheet(phoneNumber: phone),
        );
      },
      // Timeout handler
      onCodeAutoRetrievalTimeout: (_) {
        setLoadingPhone(false); //  Stop loading on timeout
      },
    );
  } catch (e) {
    setLoadingPhone(false); //  Stop loading on error
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

        // Close bottom sheet first
        Navigator.pop(context);

        // Navigate to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
      }

      phoneNumberController.clear();
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
