import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/hotel_details/review_list.dart';
import 'package:nest_user_app/views/hotel_details/widgets/review_report_card.dart';
import 'package:nest_user_app/views/review_ratings/review_rating_main.dart';

class HotelReviewReport extends StatelessWidget {
  final String hotelId;
  const HotelReviewReport({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ratings & Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          HotelReviewList(),
          Row(
            children: [
              Expanded(
                child: ActionCard(
                  icon: Icons.rate_review_rounded,
                  title: 'Review',
                  subtitle: 'Share your experience',
                  color: AppColors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ReviewRatingMain(hotelId: hotelId),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ActionCard(
                  icon: Icons.report_rounded,
                  title: 'Report',
                  subtitle: 'Report an issue',
                  color: AppColors.red,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
