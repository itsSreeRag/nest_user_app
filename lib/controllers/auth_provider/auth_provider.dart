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
  bool isLoadingPhone = false;
  bool isLoadingOtp = false;

  String _countryCode = '+91';
  TextEditingController phoneNumberController = TextEditingController();

  String get countryCode => _countryCode;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupRepasswordController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupRepasswordController.dispose();
    super.dispose();
  }

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

  // -------------------- AUTH METHODS --------------------

  Future<bool> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool('isLoggedIn') ?? false;
  }

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

  Future<bool> regUsingGoogleAcc(BuildContext context) async {
    setLoading(true);
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
    } finally {
      setLoading(false);
    }
  }

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

  Future<void> loginAccount(
    String email,
    String password,
    BuildContext context,
  ) async {
    setLoading(true);
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
    } finally {
      setLoading(false);
      emailController.clear();
      passwordController.clear();
    }
  }

  void sendOTP(BuildContext context) async {
    final phone = '$_countryCode${phoneNumberController.text.trim()}';
    setLoadingPhone(true);

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
          setLoading(false);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyNavigationBar()),
          );
        },
        onVerificationFailed: (e) {
          setLoading(false);
          AuthMessages.showError(context, 'Verification failed: ${e.message}');
        },
        onCodeSent: (id, _) {
          verificationId = id;
          showOtpField = true;
          setLoading(false);
          notifyListeners();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
            builder: (context) => OtpBottomSheet(phoneNumber: phone),
          );
        },
        onCodeAutoRetrievalTimeout: (_) {
          setLoadingPhone(false);
        },
      );
    } catch (e) {
      setLoadingPhone(false);
      AuthMessages.showError(context, 'OTP Error: $e');
    }
  }

  Future<void> verifyOTP(
    BuildContext context,
    TextEditingController otpController,
  ) async {
    isLoadingOtp = true;
    notifyListeners();
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

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyNavigationBar()),
        );
      }

      phoneNumberController.clear();
      isLoadingOtp = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isLoadingOtp = false;
      notifyListeners();
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
      String? username;
      if (user.displayName == null) {
        if (user.email != null) {
          username = user.email!.split('@')[0];
        } else {
          username =
              'user${user.phoneNumber!.substring(user.phoneNumber!.length - 4)}';
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

      await userProvider.addUser(userModel);
    } else {
      userProvider.setCurrentUser(existingUser);
    }
  }
}
