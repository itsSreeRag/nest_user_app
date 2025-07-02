import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/review_rating_controller/review_rating_controller.dart';
import 'package:nest_user_app/views/hotel_details/review_list.dart';
import 'package:nest_user_app/views/hotel_details/widgets/review_report_card.dart';
import 'package:nest_user_app/views/review_ratings/review_rating_main.dart';
import 'package:provider/provider.dart';

class HotelReviewReport extends StatelessWidget {
  final String hotelId;
  const HotelReviewReport({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(
        () => Provider.of<ReviewRatingProvider>(
          // ignore: use_build_context_synchronously
          context,
          listen: false,
        ).fetchReviews(hotelId: hotelId),
      ),
      builder: (context, asyncSnapshot) {
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
      },
    );
  }
}
