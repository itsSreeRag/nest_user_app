// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/services/favorite_service.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  List<String> favoriteHotelIds = [];
  // List<String> get favoriteHotelIds => _favoriteHotelIds;

  bool isLoading = false;
  bool _hasLoaded = false;
  bool _isInitializing = false;

  Future<void> initialize() async {
    if (!_hasLoaded && !_isInitializing) {
      await loadFavorites();
    }
  }

  Future<void> loadFavorites() async {
    if (isLoading || _isInitializing) return;

    _isInitializing = true;

    Future.microtask(() {
      isLoading = true;
      notifyListeners();
    });

    try {
      favoriteHotelIds = await _favoriteService.getFavoriteHotelIds();
      _hasLoaded = true;
    } catch (e) {
      // Handle or log error
    }

    isLoading = false;
    _isInitializing = false;
    notifyListeners();
  }

  bool isFavorite(String hotelId) {
    return favoriteHotelIds.contains(hotelId);
  }

  Future<void> toggleFavorite(String hotelId, BuildContext context) async {
    if (!_hasLoaded) {
      await loadFavorites();
    }

    if (favoriteHotelIds.contains(hotelId)) {
      await _favoriteService.removeFavorite(hotelId);
      MyCustomSnackBar.show(
        context: context,
        title: 'Remove from Saved',
        message: 'successfully removed from the saved hotels',
        backgroundColor: AppColors.red,
        accentColor: AppColors.white,
      );

      favoriteHotelIds.remove(hotelId);
    } else {
      await _favoriteService.addFavorite(hotelId);
      MyCustomSnackBar.show(
        context: context,
        title: 'Added to Saved',
        message: 'successfully added to the saved hotels',
        backgroundColor: AppColors.green,
        accentColor: AppColors.white,
      );
      favoriteHotelIds.add(hotelId);
    }
    notifyListeners();
  }

  Future<void> refreshFavorites() async {
    _hasLoaded = false;
    await loadFavorites();
  }

  void clearSaved() {
    favoriteHotelIds = [];
    isLoading = false;
    _hasLoaded = false;
    _isInitializing = false;
    notifyListeners();
  }
}
