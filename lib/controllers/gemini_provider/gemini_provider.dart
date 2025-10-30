// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:nest_user_app/services/gemini_services.dart';

// class GeminiProvider extends ChangeNotifier {
//   final GeminiServices geminiServices = GeminiServices();

//   String attractions = '';
//   bool isLoading = false;
//   String? errorMessage;

//   Future<void> fetchNearbyAttractions({required String location}) async {

//     isLoading = true;
//     errorMessage = null;
//     attractions = '';
//     notifyListeners();

//     try {
//       final stream = geminiServices.getGeminiResponse(
//         question:
//             'List 8-10 nearby destinations in $location, Kerala, arranged in order from morning to evening for a one-day trip. '
//             'For each destination, give only its name and a short one-line description in this exact format: '
//             '1. Place Name - short description. '
//             'Output only plain text. Do not include any introductions, conclusions, emojis, URLs, links, videos, or media suggestions — only the numbered list.',
//       );

//       final StringBuffer buffer = StringBuffer();

//       await for (final chunk in stream) {
//         buffer.write(chunk);
//       }
//       attractions = buffer.toString().trim();
//     } catch (e) {
//       errorMessage = 'Error fetching attractions: $e';
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nest_user_app/services/gemini_services.dart';

class GeminiProvider extends ChangeNotifier {
  final GeminiServices geminiServices = GeminiServices();

  String attractions = '';
  bool isLoading = false;
  String? errorMessage;

  Future<bool> fetchNearbyAttractions({required String location}) async {
    isLoading = true;
    errorMessage = null;
    attractions = '';
    notifyListeners();

    try {
      final stream = geminiServices.getGeminiResponse(
        question:
            'List 8–10 nearby destinations in $location, arranged in order from morning to evening for a one-day trip. '
            'For each destination, give only its name and a short one-line description in this exact format: '
            '1. Place Name - short description. '
            'Output only plain text. No introductions, conclusions, emojis, URLs, or media suggestions.',
      );

      await for (final chunk in stream) {
        attractions = chunk;
        notifyListeners();
      }

      if (attractions.isEmpty) {
        throw Exception('No data received from Gemini.');
      }

      return true; // success
    } catch (e) {
      log(e.toString());
      errorMessage = 'Error fetching attractions: $e';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
