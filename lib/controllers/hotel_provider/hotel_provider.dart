import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/services/hotel_firebase_services.dart';

class HotelProvider with ChangeNotifier {
  final HotelService _hotelService = HotelService();

  List<HotelModel> hotels = [];
  // List<HotelModel> get hotels => _hotels;

  List<HotelModel> filteredHotels = [];
  // List<HotelModel> get filteredHotels => _filteredHotels;

  bool isLoading = true;
  // bool get isLoading => isLoading;

  Timer? _debouncer;


  // Fetch hotels from Firebase
Future<void> fetchHotels() async {
  Future.microtask(() {
    isLoading = true;
    notifyListeners();
  });

  try {
    hotels = await _hotelService.fetchApprovedHotels();
    filteredHotels = hotels;
  } catch (e) {
    log("Error fetching hotels: $e");
    hotels = [];
    filteredHotels = [];
  }

  isLoading = false;
  notifyListeners();
}


  // Search hotels with debounce
  void searchHotels(String query) {
    if (_debouncer?.isActive ?? false) _debouncer!.cancel();

    _debouncer = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        filteredHotels = hotels;
      } else {
        final lowerQuery = query.toLowerCase();
        filteredHotels =
            hotels.where((hotel) {
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
    filteredHotels.sort((a, b) {
      final priceA = double.tryParse(a.basePrice) ?? 0;
      final priceB = double.tryParse(b.basePrice) ?? 0;
      return priceA.compareTo(priceB);
    });
    notifyListeners();
  }

  // Sort hotels by price: High to Low
  void sortHotelsByPriceDescending() {
    filteredHotels.sort((a, b) {
      final priceA = double.tryParse(a.basePrice) ?? 0;
      final priceB = double.tryParse(b.basePrice) ?? 0;
      return priceB.compareTo(priceA);
    });
    notifyListeners();
  }

  void clearSearch() {
    filteredHotels = hotels;
    notifyListeners();
  }

  // New method to clear both search results and text field
  void clearSearchAndText(TextEditingController controller) {
    controller.clear();
    filteredHotels = hotels;
    notifyListeners();
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }
}
