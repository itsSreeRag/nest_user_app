import 'package:flutter/material.dart';
import 'package:nest_user_app/services/favorite_service.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  List<String> _favoriteHotelIds = [];
  List<String> get favoriteHotelIds => _favoriteHotelIds;

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
    isLoading = true;
    notifyListeners();
    
    try {
      _favoriteHotelIds = await _favoriteService.getFavoriteHotelIds();
      _hasLoaded = true;
    } catch (e) {
      // print('Error loading favorites: $e');
    }
    
    isLoading = false;
    _isInitializing = false;
    notifyListeners();
  }

  bool isFavorite(String hotelId) {
    return _favoriteHotelIds.contains(hotelId);
  }

  Future<void> toggleFavorite(String hotelId) async {
    if (!_hasLoaded) {
      await loadFavorites();
    }
    
    if (_favoriteHotelIds.contains(hotelId)) {
      await _favoriteService.removeFavorite(hotelId);
      _favoriteHotelIds.remove(hotelId);
    } else {
      await _favoriteService.addFavorite(hotelId);
      _favoriteHotelIds.add(hotelId);
    }
    notifyListeners();
  }

  Future<void> refreshFavorites() async {
    _hasLoaded = false;
    await loadFavorites();
  }
}