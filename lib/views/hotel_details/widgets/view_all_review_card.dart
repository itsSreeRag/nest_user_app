import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/review_rating_controller/review_rating_controller.dart';
import 'package:nest_user_app/views/hotel_details/widgets/review_show_card.dart';
import 'package:nest_user_app/views/hotel_details/widgets/total_rating_card.dart';
import 'package:provider/provider.dart';

class ViewAllReviewCard extends StatelessWidget {
  const ViewAllReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ReviewRatingProvider>(
        builder: (context, reviewRatingProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              TotalRatingCard(
                averageRating: reviewRatingProvider.averageRating,
                totalRating: reviewRatingProvider.totalRating,
                totalReviews: reviewRatingProvider.reviews.length,
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: reviewRatingProvider.reviews.length,
                  itemBuilder: (context, index) {
                    final reviews = reviewRatingProvider.reviews[index];
                    return ReviewShowCard(reviews: reviews);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
