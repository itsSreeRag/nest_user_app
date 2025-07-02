// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/widgets/my_custom_snackbar.dart';

class LocationProvider extends ChangeNotifier {
  String? city = '';
  String? state = '';
  String? errorMessage;
  bool isLoading = false;

  Future<void> fetchCurrentLocation(BuildContext context) async {
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
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter:
              100, // Optional: minimum distance (in meters) to trigger location updates
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
        MyCustomSnackBar.show(
      context: context,
      title: 'Location Fetched',
      message: 'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
      backgroundColor: AppColors.green,
      accentColor: AppColors.white,
    );
    } catch (e) {
      MyCustomSnackBar.show(
        context: context,
        title: 'Error',
        message: 'Failed to fetch location: ${e.toString()}',
        backgroundColor: AppColors.red,
        accentColor: AppColors.white,
      );
      errorMessage = "Failed to get location: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
