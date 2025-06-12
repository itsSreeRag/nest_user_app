import 'package:flutter/material.dart';
import 'package:nest_user_app/services/favorite_service.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  List<String> _favoriteHotelIds = [];
  List<String> get favoriteHotelIds => _favoriteHotelIds;

  bool isLoading = false;

  Future<void> loadFavorites(String userId) async {
    isLoading = true;
    notifyListeners();
    _favoriteHotelIds = await _favoriteService.getFavoriteHotelIds(userId);
    isLoading = false;
    notifyListeners();
  }

  bool isFavorite(String hotelId) {
    return _favoriteHotelIds.contains(hotelId);
  }

  Future<void> toggleFavorite(String hotelId) async {
    if (_favoriteHotelIds.contains(hotelId)) {
      await _favoriteService.removeFavorite(hotelId);
      _favoriteHotelIds.remove(hotelId);
    } else {
      await _favoriteService.addFavorite(hotelId);
      _favoriteHotelIds.add(hotelId);
    }
    notifyListeners();
  }
}
