import 'package:flutter/material.dart';

class HomeAnimationProvider with ChangeNotifier {
  bool _showSearchByCity = false;
  bool _showNearHotels = false;
  bool _showRatedHotels = false;

  bool get showSearchByCity => _showSearchByCity;
  bool get showNearHotels => _showNearHotels;
  bool get showRatedHotels => _showRatedHotels;

  void triggerAnimations() {
    // Trigger search by city animation first
    _showSearchByCity = true;
    notifyListeners();

    // Trigger near hotels animation after a delay
    Future.delayed(const Duration(milliseconds: 200), () {
      _showNearHotels = true;
      notifyListeners();
    });

    // Trigger rated hotels animation after another delay
    Future.delayed(const Duration(milliseconds: 400), () {
      _showRatedHotels = true;
      notifyListeners();
    });
  }

  // Reset all animations (useful for refresh scenarios)
  void resetAnimations() {
    _showSearchByCity = false;
    _showNearHotels = false;
    _showRatedHotels = false;
    notifyListeners();
  }
}