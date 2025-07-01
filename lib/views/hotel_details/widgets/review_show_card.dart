import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:readmore/readmore.dart';

class ReviewShowCard extends StatelessWidget {
  const ReviewShowCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sreerag',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.black87,
          ),
        ),
        SizedBox(height: 10),
        RatingBarIndicator(
          rating: 4,
          itemBuilder:
              (context, _) =>
                  Icon(Icons.star, color: AppColors.secondary),
          itemCount: 5,
          itemSize: 20,
        ),
        SizedBox(height: 10),
        ReadMoreText(
          'I had a wonderful experience staying at this hotel. The rooms were very clean, the staff was extremely courteous, and the overall ambiance was peaceful. The location was also convenient, close to many attractions. I would definitely stay here again and recommend it to others.!',
          trimLines: 3,
          colorClickableText: AppColors.primary,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...See more',
          trimExpandedText: ' See less',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: AppColors.black87,
          ),
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
        Text('01/07/2025', style: TextStyle(color: AppColors.grey)),
        SizedBox(height: 20),
      ],
    );
  }
}