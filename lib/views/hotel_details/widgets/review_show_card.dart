import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/models/review_rating_model.dart';
import 'package:readmore/readmore.dart';

class ReviewShowCard extends StatelessWidget {
  final ReviewRatingModel reviews;
  const ReviewShowCard({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reviews.publicName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.black87,
          ),
        ),
        SizedBox(height: 10),
        RatingBarIndicator(
          rating: reviews.ratings,
          itemBuilder:
              (context, _) => Icon(Icons.star, color: AppColors.secondary),
          itemCount: 5,
          itemSize: 20,
        ),
        SizedBox(height: 10),
        Text(
          reviews.reviewTitle,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(height: 8),
        ReadMoreText(
          reviews.review,
          trimLines: 3,
          colorClickableText: AppColors.primary,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...See more',
          trimExpandedText: ' See less',
          style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.black87),
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 10),
        Text(
           DateFormat('dd MMM yyyy, hh:mm a').format(reviews.createdAt),
          style: TextStyle(color: AppColors.grey),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
