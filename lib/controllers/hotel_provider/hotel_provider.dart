import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nest_user_app/models/hotel_models.dart';
import 'package:nest_user_app/services/hotel_firebase_services.dart';

class HotelProvider with ChangeNotifier {
  final HotelService _hotelService = HotelService();

  List<HotelModel> _hotels = [];
  List<HotelModel> get hotels => _hotels;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  HotelProvider() {
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    _isLoading = true;
    notifyListeners();

    try {
      _hotels = await _hotelService.fetchApprovedHotels();
    } catch (e) {
      log("Error fetching hotels: $e");
      _hotels = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
