import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/services/hotel_firebase_services.dart';

class HotelProvider with ChangeNotifier {
  final HotelService _hotelService = HotelService();

  List<HotelModel> _hotels = [];
  List<HotelModel> get hotels => _hotels;

  List<HotelModel> _filteredHotels = [];
  List<HotelModel> get filteredHotels => _filteredHotels;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Timer? _debouncer;

  HotelProvider() {
    fetchHotels();
  }

  // Fetch hotels from Firebase
  Future<void> fetchHotels() async {
    _isLoading = true;
    notifyListeners();

    try {
      _hotels = await _hotelService.fetchApprovedHotels();
      _filteredHotels = _hotels;
    } catch (e) {
      log("Error fetching hotels: $e");
      _hotels = [];
      _filteredHotels = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search hotels with debounce
  void searchHotels(String query) {
    if (_debouncer?.isActive ?? false) _debouncer!.cancel();

    _debouncer = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        _filteredHotels = _hotels;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredHotels =
            _hotels.where((hotel) {
              final nameLower = hotel.stayName.toLowerCase();
              final cityLower = hotel.city.toLowerCase();
              return nameLower.contains(lowerQuery) ||
                  cityLower.contains(lowerQuery);
            }).toList();
      }
      notifyListeners();
    });
  }

  // Sort hotels by price: Low to High
  void sortHotelsByPriceAscending() {
    _filteredHotels.sort((a, b) {
      final priceA = double.tryParse(a.basePrice) ?? 0;
      final priceB = double.tryParse(b.basePrice) ?? 0;
      return priceA.compareTo(priceB);
    });
    notifyListeners();
  }

  // Sort hotels by price: High to Low
  void sortHotelsByPriceDescending() {
    _filteredHotels.sort((a, b) {
      final priceA = double.tryParse(a.basePrice) ?? 0;
      final priceB = double.tryParse(b.basePrice) ?? 0;
      return priceB.compareTo(priceA);
    });
    notifyListeners();
  }

  void clearSearch() {
    _filteredHotels = _hotels;
    notifyListeners();
  }

  // New method to clear both search results and text field
  void clearSearchAndText(TextEditingController controller) {
    controller.clear();
    _filteredHotels = _hotels;
    notifyListeners();
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }
}
