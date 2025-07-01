import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nest_user_app/models/review_rating_model.dart';
import 'package:nest_user_app/services/review_rating_services.dart';

class ReviewRatingController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ReviewRatingServices reviewRatingServices = ReviewRatingServices();

  // Private list of bookings
  List<ReviewRatingModel> _reviews = [];

  // Public getter to access bookings
  List<ReviewRatingModel> get reviews => _reviews;

  double rating = 0;

  Future<void> submitReview({
    required String publicName,
    required String hotelId,
    required String reviewTitle,
    required String review,
  }) async {
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
    reviewRatingServices.reviewSubmitFirebase(newReview, reviewId);

    log("newReview.toString()");
  }

  Future<void> fetchReviews({required String hotelId}) async {
    try {
      _reviews = await reviewRatingServices.fetchHotelReviews(hotalId: hotelId);

      notifyListeners();
    } catch (e) {
      log('Error fetching bookings: $e');
      notifyListeners();
    }
  }
}
