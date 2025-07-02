import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/review_rating_controller/review_rating_controller.dart';
import 'package:nest_user_app/views/hotel_details/widgets/review_show_card.dart';
import 'package:nest_user_app/views/hotel_details/widgets/total_rating_card.dart';
import 'package:nest_user_app/views/hotel_details/widgets/view_all_review_card.dart';
import 'package:provider/provider.dart';

class HotelReviewList extends StatelessWidget {
  const HotelReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewRatingProvider>(
      builder: (context, reviewRatingProvider, _) {
        return Column(
          children: [
            TotalRatingCard(
              averageRating: reviewRatingProvider.averageRating,
              totalRating: reviewRatingProvider.totalRating,
              totalReviews: reviewRatingProvider.reviews.length,
            ),
            SizedBox(height: 20),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount:
                  reviewRatingProvider.reviews.length < 3
                      ? reviewRatingProvider.reviews.length
                      : 3,
              itemBuilder: (context, index) {
                final reviews = reviewRatingProvider.reviews[index];
                return ReviewShowCard(reviews: reviews);
              },
            ),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _showAllReviews(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child:  Text(
                  'View all ${reviewRatingProvider.reviews.length} reviews',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void _showAllReviews(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.95,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return ViewAllReviewCard();
          },
        );
      },
    );
  }
}
