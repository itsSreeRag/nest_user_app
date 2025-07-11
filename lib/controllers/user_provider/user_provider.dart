// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UserModel? currentUser;
  bool isLoading = false;
  String? error;
  String? userImage;

  // Add user only if not exists
  Future<void> addUser(UserModel user) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _firestore.collection('users').doc(user.userId).set(user.toJson());
      currentUser = user;
      userImage = user.profileImage;

    } catch (e) {
      error = e.toString();
      debugPrint(' Error adding user: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //  Get user by ID (used in auth provider before adding)
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint(' Error fetching user by ID: $e');
      return null;
    }
  }

  //  Set current user manually
  void setCurrentUser(UserModel user) {
    currentUser = user;
    userImage = user.profileImage;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      error = 'No authenticated user found';
      // notifyListeners();
      return;
    }

    try {
      isLoading = true;
      error = null;
      // notifyListeners();

      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        final userData = UserModel.fromJson(doc.data()!);
        currentUser = userData;
        userImage = userData.profileImage;
      } else {
        currentUser = null;
        error = 'User document not found';
      }
    } catch (e) {
      error = e.toString();
      currentUser = null;
      debugPrint('Error fetching user: $e');
    } finally {
      isLoading = false;
      // notifyListeners();
    }
  }

  Future<void> updateUser(UserModel user, BuildContext context) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _firestore.collection('users').doc(user.userId).update(user.toJson());
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
      if (currentUser == null) return null;

      final uniqueFileName = currentUser!.userId;
      final ref = _storage.ref().child('images/$uniqueFileName');

      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();

      return url;
    } catch (e) {
      log(e.toString());
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
