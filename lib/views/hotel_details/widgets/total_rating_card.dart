import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nest_user_app/constants/colors.dart';

class TotalRatingCard extends StatelessWidget {
  const TotalRatingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '4.0',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 20),
        Column(
          children: [
            RatingBarIndicator(
              rating: 4,
              itemBuilder:
                  (context, _) =>
                      Icon(Icons.star, color: AppColors.secondary),
              itemCount: 5,
              itemSize: 30,
            ),
            SizedBox(height: 10),
            Text(
              '420 ratings . 210 reviews',
              style: TextStyle(
                color: AppColors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}