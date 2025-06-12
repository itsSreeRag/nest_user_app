import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/user_model.dart';
import 'package:nest_user_app/widgets/my_custom_snackbar.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  String? userImage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  UserProvider() {
    fetchUser();
  }

  Future<void> addUser(UserModel user) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestore.collection('users').doc(user.userId).set(user.toJson());
      _currentUser = user;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      debugPrint('❌ Error adding user: $e');
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchUser() async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      _error = 'No authenticated user found';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        final userData = UserModel.fromJson(doc.data()!);
        _currentUser = userData;
        userImage = userData.profileImage;
      } else {
        _currentUser = null;
        _error = 'User document not found';
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      _currentUser = null;
      debugPrint('❌ Error fetching user: $e');
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user, BuildContext context) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestore
          .collection('users')
          .doc(user.userId)
          .update(user.toJson());

      _currentUser = user;
      _isLoading = false;
      notifyListeners();

      MyCustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: 'Success',
        message: 'User updated successfully',
        icon: Icons.check_circle,
        backgroundColor: AppColors.green,
      );
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();

      MyCustomSnackBar.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: 'Error',
        message: 'Failed to update user: $_error',
        icon: Icons.error,
        backgroundColor: AppColors.red,
      );
    }
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  Future<String?> uploadImage(File image) async {
    try {
      final uniqueFileName = _currentUser!.userId.toString();
      final ref = _storage.ref().child('images/$uniqueFileName');

      // Upload the image
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
    _error = null;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
