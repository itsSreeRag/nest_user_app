import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ChangeNotifier {
  String? city = '';
  String? state = '';
  String? errorMessage;
  bool isLoading = false;

  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorMessage = "Location permission denied.";
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        errorMessage =
            "Location permission permanently denied. Open app settings.";
        isLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings : const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100, // Optional: minimum distance (in meters) to trigger location updates
  ),
      );

      // Reverse geocode to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        city = placemarks.first.locality ?? '';
        state = placemarks.first.administrativeArea ?? '';
      }
    } catch (e) {
      errorMessage = "Failed to get location: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
