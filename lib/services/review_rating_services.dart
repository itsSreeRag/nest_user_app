import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanoid/async.dart';
import 'package:nest_user_app/models/review_rating_model.dart';

class ReviewRatingServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> generateReviewId() async {
    return await nanoid(10);
  }

  Future<void> reviewSubmitFirebase(
    ReviewRatingModel review,
    String reviewId,
  ) async {
    await _firestore
        .collection('hotels')
        .doc(review.hotelId)
        .collection('review')
        .doc(reviewId)
        .set(review.toJson());
  }

  Future<List<ReviewRatingModel>> fetchHotelReviews({required String hotalId}) async {

    final snapshot =
        await _firestore
            .collection('hotels')
            .doc(hotalId)
            .collection('review')
            .get();

    return snapshot.docs
        .map((doc) => ReviewRatingModel.fromJson(doc.data()))
        .toList();
  }
}
