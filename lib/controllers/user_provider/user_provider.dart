// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/services/user_firebase_service.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';

class UserProvider with ChangeNotifier {
  final UserFirebaseService _firebaseService = UserFirebaseService();

  UserModel? currentUser;
  bool isLoading = false;
  String? error;
  String? userImage;

  Future<void> addUser(UserModel user) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _firebaseService.addUser(user);
      currentUser = user;
      userImage = user.profileImage;
    } catch (e) {
      error = e.toString();
      debugPrint('Error adding user: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      return await _firebaseService.getUserById(userId);
    } catch (e) {
      debugPrint('Error fetching user by ID: $e');
      return null;
    }
  }

  void setCurrentUser(UserModel user) {
    currentUser = user;
    userImage = user.profileImage;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    try {
      isLoading = true;
      error = null;
      final userData = await _firebaseService.fetchCurrentUser();
      if (userData != null) {
        currentUser = userData;
        userImage = userData.profileImage;
      } else {
        currentUser = null;
        error = 'User not found';
      }
    } catch (e) {
      error = e.toString();
      debugPrint('Error fetching user: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(UserModel user, BuildContext context) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _firebaseService.updateUser(user);
      currentUser = user;

      MyCustomSnackBar.show(
        context: context,
        title: 'Success',
        message: 'User updated successfully',
        icon: Icons.check_circle,
        backgroundColor: AppColors.green,
      );
    } catch (e) {
      error = e.toString();
      MyCustomSnackBar.show(
        context: context,
        title: 'Error',
        message: 'Failed to update user: $error',
        icon: Icons.error,
        backgroundColor: AppColors.red,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      String? oldImageUrl = currentUser!.profileImage;
      if (currentUser == null) {
        return null;
      }
      if (oldImageUrl != null) {
        final imageExist = await _firebaseService.doesImageExist(oldImageUrl);
        log(imageExist.toString());
        if (imageExist) {
          final imagedelete = await _firebaseService.deleteProfileImage(
            oldImageUrl,
          );
          log('delte ${imagedelete.toString()}');
        }
      }
      return await _firebaseService.uploadImage(image, currentUser!.userId);
    } catch (e) {
      log('Upload error: $e');
      return null;
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  void clearUser() {
    currentUser = null;
    error = null;
    isLoading = false;
    userImage = null;
    notifyListeners();
  }
}
