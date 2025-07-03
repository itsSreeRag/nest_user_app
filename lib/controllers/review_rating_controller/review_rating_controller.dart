// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/review_rating_model.dart';
import 'package:nest_user_app/services/review_rating_services.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';

class ReviewRatingProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ReviewRatingServices reviewRatingServices = ReviewRatingServices();

  // Private list of bookings
  List<ReviewRatingModel> _reviews = [];

  // Public getter to access bookings
  List<ReviewRatingModel> get reviews => _reviews;
  int totalRating = 0;
  double averageRating = 0;

  double rating = 0;

  Future<void> submitReview({
    required BuildContext context,
    required String publicName,
    required String hotelId,
    required String reviewTitle,
    required String review,
  }) async {
    try {
      final reviewId = await reviewRatingServices.generateReviewId();

      final newReview = ReviewRatingModel(
        ratings: rating,
        review: review,
        userId: _auth.currentUser!.uid,
        hotelId: hotelId,
        reviewTitle: reviewTitle,
        publicName: publicName,
        reviewId: reviewId,
        createdAt: DateTime.now(),
      );

      await reviewRatingServices.reviewSubmitFirebase(newReview, reviewId);

      _reviews.add(newReview);
      notifyListeners();

      Navigator.pop(context);

      MyCustomSnackBar.show(
        context: context,
        title: 'Success',
        message: 'Review submitted successfully!',
        backgroundColor: AppColors.green,
        accentColor: AppColors.white,
      );
    } catch (e) {
      MyCustomSnackBar.show(
        context: context,
        title: 'Error',
        message: 'Failed to submit review. Please try again.',
        backgroundColor: Colors.red,
        accentColor: Colors.white,
      );
    }
  }

  Future<void> fetchReviews({required String hotelId}) async {
    try {
      _reviews = await reviewRatingServices.fetchHotelReviews(hotalId: hotelId);
      totalRating = _reviews.fold(
        0,
        (sum, review) => sum + review.ratings.toInt(),
      );
      if (_reviews.isNotEmpty) {
        averageRating = double.parse(
          (totalRating / _reviews.length).toStringAsFixed(1),
        );
      } else {
        averageRating = 0.0;
      }
      notifyListeners();
    } catch (e) {
      log('Error fetching bookings: $e');
      notifyListeners();
    }
  }
}
